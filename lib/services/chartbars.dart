import 'package:flutter/material.dart';

class chartBars extends StatelessWidget {
  final String dayInfo;
  final double expenditure;
  final double totalexpenditurePercentage;

  chartBars(
      {required this.dayInfo,
      required this.expenditure,
      required this.totalexpenditurePercentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Column(
              children: <Widget>[
                Container(
                    height: constraints.maxHeight * 0.10,
                    child: FittedBox(
                        child: Text('Rs ${expenditure.toStringAsFixed(0)}'))),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  width: 15,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                          color: Colors.cyan[100],
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: totalexpenditurePercentage,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.2),
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                    height: constraints.maxHeight * 0.10,
                    child: FittedBox(child: Text(dayInfo))),
              ],
            ));
  }
}
