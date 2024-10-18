import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/application/transactions/transaction_cubit.dart';
import 'package:wallet_guru/application/transactions/transaction_state.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/transactions/widgets/transaction_details_popup.dart';

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

  List<FlSpot> _createSpots(List<TransactionsModel> transactions) {
    if (transactions.isEmpty) return [const FlSpot(0, 0)];

    final Map<DateTime, double> dailyTotals = {};
    for (var t in transactions) {
      final date =
          DateTime(t.createdAt.year, t.createdAt.month, t.createdAt.day);
      final amount = t.type == 'IncomingPayment'
          ? (t.incomingAmount?.value ?? 0)
          : -(t.receiveAmount?.value ?? 0);
      dailyTotals[date] = (dailyTotals[date] ?? 0) + amount;
    }

    final sortedDates = dailyTotals.keys.toList()..sort();
    double cumulativeTotal = 0;
    return sortedDates.asMap().entries.map((entry) {
      final index = entry.key;
      final date = entry.value;
      cumulativeTotal += dailyTotals[date]!;
      return FlSpot(index.toDouble(), cumulativeTotal);
    }).toList();
  }

  void _initializeDates(List<TransactionsModel> transactions) {
    if (transactions.isNotEmpty) {
      _startDate = transactions
          .map((t) => t.createdAt)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      _endDate = transactions
          .map((t) => t.createdAt)
          .reduce((a, b) => a.isAfter(b) ? a : b);
    } else {
      _startDate = DateTime.now().subtract(const Duration(days: 30));
      _endDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionCubit, TransactionState>(
      listener: (context, state) {
        if (state is TransactionError) {
          GoRouter.of(context).pushReplacementNamed(Routes.errorScreen.name);
        }
      },
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionLoaded) {
          _initializeDates(state.payments);
          final filteredTransactions = state.payments;
          final total = _calculateTotal(filteredTransactions);
          final spots = _createSpots(filteredTransactions);
          final l10n = AppLocalizations.of(context)!;

          _startDate = state.startDate ?? filteredTransactions.first.createdAt;
          _endDate = state.endDate ?? filteredTransactions.last.createdAt;
          _selectedTransactionType = state.transactionType ?? 'All';

          return WalletGuruLayout(
            showSafeArea: true,
            showSimpleStyle: false,
            showLoggedUserAppBar: true,
            showBottomNavigationBar: false,
            actionAppBar: () {
              GoRouter.of(context).pushReplacementNamed(Routes.home.name);
            },
            pageAppBarTitle: l10n.transactionsTitlePage,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildChartCard(context, total, spots),
                    Expanded(
                        child: _buildTransactionsList(filteredTransactions)),
                  ],
                ),
              ),
            ],
          );
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
        color: AppColorSchema.of(context).cardTwoColor,
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
        final ThemeData theme = Theme.of(context);
        final newTheme = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: AppColorSchema.of(context).buttonColor,
            onPrimary: Colors.white,
            surface: Colors.grey[900],
            onSurface: Colors.white,
            secondary: Colors.purple[800],
            onSecondary: Colors.white,
          ),
          textTheme: theme.textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        );

        DateTime firstDate =
            _startDate.isBefore(_endDate) ? _startDate : _endDate;
        DateTime lastDate =
            _endDate.isAfter(_startDate) ? _endDate : _startDate;

        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: firstDate.subtract(const Duration(days: 365)),
          lastDate: lastDate.add(const Duration(days: 365)),
          initialDateRange: DateTimeRange(start: firstDate, end: lastDate),
          builder: (BuildContext context, Widget? child) {
            return Theme(data: newTheme, child: Container(child: child));
          },
        );
        if (picked != null) {
          setState(() {
            _startDate = picked.start;
            _endDate = picked.end;
          });
          context.read<TransactionCubit>().loadTransactions(
                startDate: picked.start,
                endDate: picked.end,
                transactionType: _selectedTransactionType,
              );
        }
      },
      text:
          '${DateFormat('MMM d, y').format(_startDate)} - ${DateFormat('MMM d, y').format(_endDate)}',
      fontSize: 12,
      height: 30,
      width: 180,
      color: AppColorSchema.of(context).buttonTwoColor,
    );
  }

  Widget _buildTransactionTypeDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColorSchema.of(context).buttonTwoColor,
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
          if (newValue != null) {
            context.read<TransactionCubit>().loadTransactions(
                  startDate: _startDate,
                  endDate: _endDate,
                  transactionType: newValue,
                );
          }
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
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final amount = transaction.type == 'IncomingPayment'
            ? (transaction.incomingAmount?.value ?? 0)
            : (transaction.receiveAmount?.value ?? 0);
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
                        '${transaction.type == 'IncomingPayment' ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
                    fontSize: 16,
                    color: AppColorSchema.of(context).primaryText,
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TransactionDetailsPopup(
                              transaction: transaction);
                        },
                      );
                    },
                    child: Icon(Icons.info_outline,
                        color: AppColorSchema.of(context).primaryText),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                  color:
                      AppColorSchema.of(context).primaryText.withOpacity(0.5)),
            ),
          ],
        );
      },
    );
  }

  double _calculateTotal(List<TransactionsModel> transactions) {
    return transactions.fold(0.0, (sum, t) {
      final amount = t.type == 'IncomingPayment'
          ? (t.incomingAmount?.value ?? 0)
          : (t.receiveAmount?.value ?? 0);
      return sum + (t.type == 'IncomingPayment' ? amount : -amount);
    });
  }
}
