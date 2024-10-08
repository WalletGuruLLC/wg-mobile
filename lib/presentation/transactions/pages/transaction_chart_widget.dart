import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'dart:convert';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class TransactionChartWidget extends StatefulWidget {
  const TransactionChartWidget({super.key});

  @override
  _TransactionChartWidgetState createState() => _TransactionChartWidgetState();
}

class _TransactionChartWidgetState extends State<TransactionChartWidget> {
  late List<Transaction> _transactions;
  late DateTime _startDate;
  late DateTime _endDate;
  String _selectedTransactionType = 'All';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
    _initializeDates();
  }

  void _loadTransactions() {
    final jsonData = jsonDecode(mockJsonData);
    _transactions = (jsonData['transactions'] as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
    _transactions.sort((a, b) => a.createDate.compareTo(b.createDate));
  }

  void _initializeDates() {
    _startDate = _transactions.first.createDate;
    _endDate = _transactions.last.createDate;
  }

  List<Transaction> _getFilteredTransactions() {
    return _transactions.where((t) {
      final isInDateRange =
          t.createDate.isAfter(_startDate.subtract(const Duration(days: 1))) &&
              t.createDate.isBefore(_endDate.add(const Duration(days: 1)));
      final matchesType = _selectedTransactionType == 'All' ||
          t.typeOfTransaction == _selectedTransactionType;
      return isInDateRange && matchesType;
    }).toList();
  }

  double _calculateTotal(List<Transaction> transactions) {
    return transactions.fold(0, (sum, t) => sum + t.value);
  }

  List<FlSpot> _createSpots(List<Transaction> transactions) {
    if (transactions.isEmpty) return [const FlSpot(0, 0)];

    final Map<int, double> monthlyTotals = {};
    for (var t in transactions) {
      final month = t.createDate.month - 1; // 0-based month
      monthlyTotals[month] = (monthlyTotals[month] ?? 0) + t.value;
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
    final filteredTransactions = _getFilteredTransactions();
    final total = _calculateTotal(filteredTransactions);
    final spots = _createSpots(filteredTransactions);

    return WalletGuruLayout(
      showBackButton: false,
      showBottomNavigationBar: false,
      showNotLoggedAppBar: true,
      children: [
        Container(
          width: 350,
          height: 211,
          decoration: BoxDecoration(
            color: const Color(0xFF212139),
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
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    _buildDateRangePicker(),
                  ],
                ),
                const SizedBox(height: 8),
                _buildTransactionTypeDropdown(),
                const SizedBox(height: 8),
                SizedBox(
                  width: 331,
                  height: 115,
                  child: Skeletonizer(
                    enabled: _isLoading,
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
                                return Text(months[monthIndex],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10));
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
                        minY: spots
                            .map((s) => s.y)
                            .reduce((a, b) => a < b ? a : b),
                        maxY: spots
                            .map((s) => s.y)
                            .reduce((a, b) => a > b ? a : b),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                            ),
                            barWidth: 4,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.withOpacity(0.3),
                                  Colors.purple.withOpacity(0.3),
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
        ),
      ],
    );
  }

  Widget _buildDateRangePicker() {
    return GestureDetector(
      onTap: () async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: _transactions.first.createDate,
          lastDate: _transactions.last.createDate,
          initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
        );
        if (picked != null) {
          setState(() {
            _isLoading = true;
            _startDate = picked.start;
            _endDate = picked.end;
          });
          await Future.delayed(
              const Duration(milliseconds: 500)); // Simular carga
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '${DateFormat('MMM d').format(_startDate)} - ${DateFormat('MMM d').format(_endDate)}',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeDropdown() {
    return DropdownButton<String>(
      value: _selectedTransactionType,
      dropdownColor: const Color(0xFF212139),
      style: const TextStyle(color: Colors.white, fontSize: 12),
      onChanged: (String? newValue) {
        setState(() {
          _selectedTransactionType = newValue!;
        });
      },
      items: <String>['All', 'Debits', 'Credits']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class Transaction {
  final String typeOfTransaction;
  final DateTime createDate;
  final double value;

  Transaction({
    required this.typeOfTransaction,
    required this.createDate,
    required this.value,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      typeOfTransaction: json['typeOfTransaction'],
      createDate: DateTime.parse(json['createDate']),
      value: json['value'].toDouble(),
    );
  }
}

const String mockJsonData = '''
{
  "statusCode": 200,
  "customCode": "WGE0077",
  "customMessage": "The wallet was successfully retrieved.",
  "customMessageEs": "La billetera se obtuvo con éxito.",
  "transactions": [
    {
      "typeOfTransaction" : "Debits",
      "createDate": "2024-11-25",
      "value": 200.00
    },
    {
      "typeOfTransaction" : "Credits",
      "createDate": "2024-10-13",
      "value": 50.00
    },
    {
      "typeOfTransaction" : "Debits",
      "createDate": "2024-01-05",
      "value": 1.00
    },
    {
      "typeOfTransaction" : "Credits",
      "createDate": "2024-02-25",
      "value": 7.00
    },
    {
      "typeOfTransaction" : "Debits",
      "createDate": "2024-02-13",
      "value": 1.75
    },
    {
      "typeOfTransaction" : "Credits",
      "createDate": "2024-01-10",
      "value": 30.0
    },
    {
      "typeOfTransaction" : "Credits",
      "createDate": "2024-06-06",
      "value": 1.5
    },
    {
      "typeOfTransaction" : "Credits",
      "createDate": "2024-07-11",
      "value": 0.10
    },
    {
      "typeOfTransaction" : "Credits",
      "createDate": "2024-03-18",
      "value": 8.0
    },
    {
      "typeOfTransaction" : "Debits",
      "createDate": "2024-09-01",
      "value": 500.00
    },
    {
      "typeOfTransaction" : "Debits",
      "createDate": "2024-03-01",
      "value": 53.00
    },
    {
      "typeOfTransaction" : "Debits",
      "createDate": "2024-09-31",
      "value": 53.00
    }
  ]
}
''';