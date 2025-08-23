import 'package:expense_tracker/barGraph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  /// Always return a fresh list of bars
  List<IndividualBar> get barData => [
    IndividualBar(x: 0, y: sunAmount),
    IndividualBar(x: 1, y: monAmount),
    IndividualBar(x: 2, y: tueAmount),
    IndividualBar(x: 3, y: wedAmount),
    IndividualBar(x: 4, y: thurAmount),
    IndividualBar(x: 5, y: friAmount),
    IndividualBar(x: 6, y: satAmount),
  ];
}
