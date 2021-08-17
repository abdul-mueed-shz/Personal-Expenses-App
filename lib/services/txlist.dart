import 'package:flutter/material.dart';
import 'package:personalexpenseapp/models/tx.dart';
import 'package:intl/intl.dart';

class TxList extends StatelessWidget {
  final List<Transx> transactions;
  final Function removeTransaction;
  TxList({required this.transactions, required this.removeTransaction});
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(children: <Widget>[
                  Text(
                    'No data found',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image(
                      image: AssetImage('assets/images/nodata.png'),
                      //fit: BoxFit.cover,
                    ),
                  ),
                ]))
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, transx) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                elevation: 6.0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                            'Rs ${transactions[transx].amount.toStringAsFixed(1)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[transx].title,
                    style: Theme.of(context).textTheme.title,
                    // TextStyle(
                    //   fontSize: 16.0,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  subtitle: Text(
                    DateFormat().format(transactions[transx].date),
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                          onPressed: () {
                            removeTransaction(transactions[transx].ID);
                          },
                          label: Text('Delete'),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            removeTransaction(transactions[transx].ID);
                          },
                          icon: Icon(Icons.delete),
                          //color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
          );
  }
}
