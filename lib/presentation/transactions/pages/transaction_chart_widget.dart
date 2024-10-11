import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/application/transactions/transaction_cubit.dart';
import 'package:wallet_guru/application/transactions/transaction_state.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';

class TransactionChartWidget extends StatefulWidget {
  const TransactionChartWidget({super.key});

  @override
  _TransactionChartWidgetState createState() => _TransactionChartWidgetState();
}

class _TransactionChartWidgetState extends State<TransactionChartWidget> {
  late DateTime _startDate;
  late DateTime _endDate;
  String _selectedTransactionType = 'All';

  @override
  void initState() {
    super.initState();
    context.read<TransactionCubit>().loadTransactions();
  }

  void _initializeDates(List<TransactionsModel> transactions) {
    if (transactions.isNotEmpty) {
      _startDate = transactions.first.createdAt;
      _endDate = transactions.last.createdAt;
    } else {
      _startDate = DateTime.now().subtract(const Duration(days: 30));
      _endDate = DateTime.now();
    }
  }

  List<TransactionsModel> _getFilteredTransactions(
      List<TransactionsModel> transactions) {
    return transactions.where((t) {
      final isInDateRange =
          t.createdAt.isAfter(_startDate.subtract(const Duration(days: 1))) &&
              t.createdAt.isBefore(_endDate.add(const Duration(days: 1)));
      final matchesType = _selectedTransactionType == 'All' ||
          (_selectedTransactionType == 'Credits' &&
              t.type == 'IncomingPayment') ||
          (_selectedTransactionType == 'Debits' && t.type == 'OutgoingPayment');
      return isInDateRange && matchesType;
    }).toList();
  }

  double _calculateTotal(List<TransactionsModel> transactions) {
    return transactions.fold(0, (sum, t) {
      final amount = t.type == 'IncomingPayment'
          ? t.incomingAmount?.value ?? 0
          : t.receiveAmount?.value ?? 0;
      return sum + (t.type == 'IncomingPayment' ? amount : -amount);
    });
  }

  List<FlSpot> _createSpots(List<TransactionsModel> transactions) {
    if (transactions.isEmpty) return [const FlSpot(0, 0)];

    final Map<int, double> monthlyTotals = {};
    for (var t in transactions) {
      final month = t.createdAt.month - 1; // 0-based month
      final amount = t.type == 'IncomingPayment'
          ? t.incomingAmount?.value ?? 0
          : -(t.receiveAmount?.value ?? 0);
      monthlyTotals[month] = (monthlyTotals[month] ?? 0) + amount;
    }

    double cumulativeTotal = 0;
    return monthlyTotals.entries.map((e) {
      cumulativeTotal += e.value;
      return FlSpot(e.key.toDouble(), cumulativeTotal);
    }).toList()
      ..sort((a, b) => a.x.compareTo(b.x));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionLoaded) {
          _initializeDates(state.payments);
          final filteredTransactions = _getFilteredTransactions(state.payments);
          final total = _calculateTotal(filteredTransactions);
          final spots = _createSpots(filteredTransactions);

          return WalletGuruLayout(
            showBackButton: true,
            showBottomNavigationBar: true,
            showLoggedUserAppBar: true,
            pageAppBarTitle: 'Transactions',
            mainAxisAlignment: MainAxisAlignment.start,
            actionAppBar: () {},
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildChartCard(context, total, spots),
                    _buildTransactionsList(filteredTransactions),
                  ],
                ),
              ),
              // _buildChartCard(context, total, spots),
              // _buildTransactionsList(filteredTransactions),
            ],
          );
        } else if (state is TransactionError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildChartCard(
      BuildContext context, double total, List<FlSpot> spots) {
    return Container(
      width: 350,
      height: 211,
      decoration: BoxDecoration(
        color: AppColorSchema.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBase(
                  text: '\$${total.abs().toStringAsFixed(2)}',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColorSchema.of(context).primaryText,
                ),
                _buildDateRangePicker(),
              ],
            ),
            const SizedBox(height: 8),
            _buildTransactionTypeDropdown(),
            const SizedBox(height: 8),
            Expanded(
              child: SizedBox(
                width: 331,
                height: 115,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const months = [
                              'J',
                              'F',
                              'M',
                              'A',
                              'M',
                              'J',
                              'J',
                              'A',
                              'S',
                              'O',
                              'N',
                              'D'
                            ];
                            final monthIndex = value.toInt() % 12;
                            return TextBase(
                              text: months[monthIndex],
                              fontSize: 10,
                              color: AppColorSchema.of(context).accentText,
                            );
                          },
                          interval: 1,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 11,
                    minY: spots.map((s) => s.y).reduce((a, b) => a < b ? a : b),
                    maxY: spots.map((s) => s.y).reduce((a, b) => a > b ? a : b),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColorSchema.of(context).primary,
                            AppColorSchema.of(context).secondary
                          ],
                        ),
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              AppColorSchema.of(context)
                                  .primary
                                  .withOpacity(0.3),
                              AppColorSchema.of(context)
                                  .secondary
                                  .withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return CustomButton(
      onPressed: () async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: _startDate,
          lastDate: _endDate,
          initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
        );
        if (picked != null) {
          setState(() {
            _startDate = picked.start;
            _endDate = picked.end;
          });
          context.read<TransactionCubit>().loadTransactions();
        }
      },
      text:
          '${DateFormat('MMM d').format(_startDate)} - ${DateFormat('MMM d').format(_endDate)}',
      fontSize: 12,
      height: 30,
      width: 150,
      color: AppColorSchema.of(context).secondary,
    );
  }

  Widget _buildTransactionTypeDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColorSchema.of(context).secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        value: _selectedTransactionType,
        dropdownColor: AppColorSchema.of(context).cardColor,
        style: TextStyle(
            color: AppColorSchema.of(context).primaryText, fontSize: 12),
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down,
            color: AppColorSchema.of(context).primaryText),
        onChanged: (String? newValue) {
          setState(() {
            _selectedTransactionType = newValue!;
          });
          context.read<TransactionCubit>().loadTransactions();
        },
        items: <String>['All', 'Credits', 'Debits']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: TextBase(
              text: value,
              fontSize: 12,
              color: AppColorSchema.of(context).primaryText,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionsList(List<TransactionsModel> transactions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Column(
          children: [
            ListTile(
              title: TextBase(
                text:
                    transaction.type == 'IncomingPayment' ? 'Credit' : 'Debit',
                fontSize: 16,
                color: AppColorSchema.of(context).primaryText,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextBase(
                    text:
                        '${transaction.type == 'IncomingPayment' ? '+' : '-'}\$${(transaction.type == 'IncomingPayment' ? transaction.incomingAmount?.value : transaction.receiveAmount?.value)?.toStringAsFixed(2) ?? '0.00'}',
                    fontSize: 16,
                    color: AppColorSchema.of(context).primaryText,
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.info_outline,
                      color: AppColorSchema.of(context).primaryText),
                ],
              ),
            ),
            Divider(
                color:
                    AppColorSchema.of(context).secondaryText.withOpacity(0.5)),
          ],
        );
      },
    );
  }
}
