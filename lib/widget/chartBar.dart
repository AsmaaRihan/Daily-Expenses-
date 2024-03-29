import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label;
  final double spendingAmount;
  final double spendingTotalPer;
  ChartBar(this.label, this.spendingAmount, this.spendingTotalPer);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: 20,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(2)}'))),
          SizedBox(height: 4),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingTotalPer,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
