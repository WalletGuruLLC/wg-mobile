import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/domain/transactions/models/interval_data.dart';
import 'package:wallet_guru/presentation/core/widgets/loading_widget.dart';
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

enum TimeRange { day1, day7, month1, month6, year1 }

class _TransactionChartWidgetState extends State<TransactionChartWidget> {
  late DateTime _startDate;
  late DateTime _endDate;
  String _selectedTransactionType = 'All';
  TimeRange _selectedRange = TimeRange.day7;

  @override
  void initState() {
    super.initState();
    _initializeDates();
    _loadTransactions();
  }

  void _initializeDates() {
    final intervalData = _getIntervalData(_selectedRange);
    _startDate = intervalData.start;
    _endDate = DateTime.now();
  }

  void _loadTransactions() {
    context.read<TransactionCubit>().loadTransactions(
          startDate: _startDate,
          endDate: _endDate,
          transactionType: _selectedTransactionType,
        );
  }

  IntervalData _getIntervalData(TimeRange range) {
    final now = DateTime.now();

    switch (range) {
      case TimeRange.day1:
        final start = DateTime(now.year, now.month, now.day)
            .subtract(const Duration(days: 1));
        return IntervalData(start, const Duration(hours: 1), 24);
      case TimeRange.day7:
        final start = now.subtract(const Duration(days: 6));
        return IntervalData(start, const Duration(days: 1), 7);
      case TimeRange.month1:
        final start = DateTime(now.year, now.month - 1, now.day);
        return IntervalData(start, const Duration(days: 1), 30);
      case TimeRange.month6:
        final start = DateTime(now.year, now.month - 6, now.day);
        return IntervalData(
            start, const Duration(days: 5), 36); // Aproximadamente cada 5 días
      case TimeRange.year1:
        final start = DateTime(now.year - 1, now.month, now.day);
        return IntervalData(
            start, const Duration(days: 30), 12); // Aproximadamente mensual
    }
  }

  List<FlSpot> _createSpots(List<TransactionsModel> transactions) {
    if (transactions.isEmpty) return [const FlSpot(0, 0)];

    final intervalData = _getIntervalData(_selectedRange);
    final datePoints = _generateDatePoints(
        intervalData.start, _endDate, intervalData.interval);
    final groupedData = _groupTransactionsByDate(
        transactions, datePoints.keys.toList(), intervalData.interval);

    // Generar spots con valores acumulados
    var cumulativeTotal = 0.0;
    final spots = <FlSpot>[];

    for (var date in datePoints.keys.toList()..sort()) {
      if (groupedData.containsKey(date)) {
        cumulativeTotal += groupedData[date]!;
      }
      spots.add(FlSpot(datePoints[date]!.toDouble(), cumulativeTotal));
    }

    return spots;
  }

  Map<DateTime, int> _generateDatePoints(
      DateTime start, DateTime end, Duration interval) {
    final points = <DateTime, int>{};
    var current = start;
    var index = 0;

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      points[_normalizeDate(current, interval)] = index++;
      current = current.add(interval);
    }

    return points;
  }

  DateTime _normalizeDate(DateTime date, Duration interval) {
    if (interval.inHours == 1) {
      return DateTime(date.year, date.month, date.day, date.hour);
    }
    return DateTime(date.year, date.month, date.day);
  }

  Map<DateTime, double> _groupTransactionsByDate(
      List<TransactionsModel> transactions,
      List<DateTime> datePoints,
      Duration interval) {
    final groupedData = <DateTime, double>{};

    for (var transaction in transactions) {
      final date = _normalizeDate(transaction.createdAt, interval);
      if (!datePoints.contains(date)) continue;

      final amount = transaction.type == 'IncomingPayment'
          ? (transaction.incomingAmount?.value ?? 0)
          : -(transaction.receiveAmount?.value ?? 0);

      groupedData[date] = (groupedData[date] ?? 0) + amount;
    }

    return groupedData;
  }

  String _getRangeText(TimeRange range) {
    switch (range) {
      case TimeRange.day1:
        return '1D';
      case TimeRange.day7:
        return '7D';
      case TimeRange.month1:
        return '1M';
      case TimeRange.month6:
        return '6M';
      case TimeRange.year1:
        return '1Y';
    }
  }

  Widget _buildTimeRangeSelector() {
    return Row(
      children: TimeRange.values.map((range) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedRange = range;
                _initializeDates();
              });
              _loadTransactions();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedRange == range
                    ? AppColorSchema.of(context).primary
                    : AppColorSchema.of(context).buttonTwoColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextBase(
                text: _getRangeText(range),
                fontSize: 12,
                color: _selectedRange == range
                    ? Colors.white
                    : AppColorSchema.of(context).primaryText,
              ),
            ),
          ),
        );
      }).toList(),
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
            setState(() {
              _selectedTransactionType = newValue;
            });
            _loadTransactions();
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

  Widget _buildAxisLabel(double value, TimeRange range) {
    final intervalData = _getIntervalData(range);
    final date = intervalData.start.add(intervalData.interval * value.toInt());

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Transform.rotate(
        angle: -0.5, // Rota las etiquetas (en radianes)
        child: TextBase(
          text: DateFormat('dd/MM').format(date),
          fontSize: 10,
          color: AppColorSchema.of(context).accentText,
        ),
      ),
    );
  }

  double _getAxisInterval(TimeRange range) {
    switch (range) {
      case TimeRange.day1:
        return 4; // Cada 4 horas
      case TimeRange.day7:
        return 1; // Cada día
      case TimeRange.month1:
        return 5; // Cada 5 días
      case TimeRange.month6:
        return 6; // Cada 6 días
      case TimeRange.year1:
        return 1; // Cada mes (aproximado)
    }
  }

  Widget _buildChartCard(
      BuildContext context, double total, List<FlSpot> spots) {
    final intervalData = _getIntervalData(_selectedRange);
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      height: 220,
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
              children: [_buildTimeRangeSelector()],
            ),
            const SizedBox(height: 8),
            _buildTransactionTypeDropdown(),
            const SizedBox(height: 8),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20), // Asegura bordes redondeados
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0), // Añade más padding inferior
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: _getAxisInterval(_selectedRange),
                              getTitlesWidget: (value, meta) =>
                                  _buildAxisLabel(value, _selectedRange),
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
                        maxX: intervalData.pointCount.toDouble() - 1,
                        minY: spots.isEmpty
                            ? 0
                            : spots
                                .map((s) => s.y)
                                .reduce((a, b) => a < b ? a : b),
                        maxY: spots.isEmpty
                            ? 0
                            : spots
                                .map((s) => s.y)
                                .reduce((a, b) => a > b ? a : b),
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
              ),
            ),
          ],
        ),
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
          final isProvider = transaction.metadata.type == "PROVIDER";

          final amount = transaction.type == 'IncomingPayment'
              ? (transaction.incomingAmount?.value ?? 0)
              : (transaction.receiveAmount?.value ?? 0);
          String displayName;
          if (isProvider) {
            displayName =
                "${transaction.receiverName}${transaction.metadata.contentName.isNotEmpty ? ' - ${transaction.metadata.contentName}' : ''}";
          } else {
            displayName = transaction.type == 'IncomingPayment'
                ? transaction.senderName
                : transaction.receiverName;
          }
          return Column(
            children: [
              ListTile(
                title: TextBase(
                  text: displayName,
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
                    color: AppColorSchema.of(context)
                        .primaryText
                        .withOpacity(0.5)),
              ),
            ],
          );
        });
  }

  double _calculateTotal(List<TransactionsModel> transactions) {
    return transactions.fold(0.0, (sum, t) {
      final amount = t.type == 'IncomingPayment'
          ? (t.incomingAmount?.value ?? 0)
          : (t.receiveAmount?.value ?? 0);
      return sum + (t.type == 'IncomingPayment' ? amount : -amount);
    });
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
          return const Center(
              child: LoadingWidget(
            showSafeArea: true,
            showSimpleStyle: false,
            showLoggedUserAppBar: false,
            showBottomNavigationBar: false,
          ));
        } else if (state is TransactionLoaded) {
          final total = _calculateTotal(state.processedPayments);
          final spots = _createSpots(state.processedPayments);
          final l10n = AppLocalizations.of(context)!;

          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) {
                return;
              }
              final navigator = Navigator.of(context);
              navigator.pop();
            },
            child: WalletGuruLayout(
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
                          child:
                              _buildTransactionsList(state.processedPayments)),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
