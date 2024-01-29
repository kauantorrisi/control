import 'package:control/bar%20graph/individual_bar.dart';

class BarData {
  final double segAmount;
  final double terAmount;
  final double quaAmount;
  final double quiAmount;
  final double sexAmount;
  final double sabAmount;
  final double domAmount;

  List<IndividualBar> barData = [];

  BarData({
    required this.segAmount,
    required this.terAmount,
    required this.quaAmount,
    required this.quiAmount,
    required this.sexAmount,
    required this.sabAmount,
    required this.domAmount,
  });

  // initialize
  void initializeBarData() {
    barData = [
    IndividualBar(x: 0, y: segAmount),
    IndividualBar(x: 1, y: terAmount),
    IndividualBar(x: 2, y: quaAmount),
    IndividualBar(x: 3, y: quiAmount),
    IndividualBar(x: 4, y: sexAmount),
    IndividualBar(x: 5, y: sabAmount),
    IndividualBar(x: 6, y: domAmount),
    ];
  }
}
