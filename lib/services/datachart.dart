import 'package:flutter/material.dart';
import 'package:personalexpenseapp/models/tx.dart';
import 'package:intl/intl.dart';
import 'package:personalexpenseapp/services/chartbars.dart';

class Chart extends StatelessWidget {
  final List<Transx> allweektransactions;
  Chart({required this.allweektransactions});

  List<Map<String, dynamic>> get allweekTransactionValues {
    return List.generate(7, (index) {
      final dayofWeek = DateTime.now().subtract(Duration(days: index));
      double sum = 0;
      for (int i = 0; i < allweektransactions.length; i++) {
        if (allweektransactions[i].date.month == dayofWeek.month &&
            allweektransactions[i].date.day == dayofWeek.day &&
            allweektransactions[i].date.year == dayofWeek.year) {
          sum += allweektransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(dayofWeek), 'amount': sum};
    });
  }

  double get totalExpenditure {
    return allweekTransactionValues.fold(0.0, (sum, element) {
      print(sum + (element['amount']));
      return (sum + (element['amount']));
    });
  }

  @override
  Widget build(BuildContext context) {
    print(allweekTransactionValues);
    return Card(
      margin: EdgeInsets.all(25.0),
      elevation: 7.0,
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: allweekTransactionValues
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: (chartBars(
                        dayInfo: e['day'],
                        expenditure: e['amount'],
                        totalexpenditurePercentage: e['amount'] == 0.0
                            ? 0.0
                            : e['amount'] / totalExpenditure)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
