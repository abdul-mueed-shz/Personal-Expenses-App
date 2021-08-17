import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTx extends StatefulWidget {
  final Function addTx;
  NewTx({required this.addTx});

  @override
  State<NewTx> createState() => _NewTxState();
}

class _NewTxState extends State<NewTx> {
  //Data
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _chosenDate = DateTime(1800);
  //Functions
  void _submitIt() {
    final _title = _titleController.text;
    final _amount = double.parse(_amountController.text);
    if (_title.isEmpty || (_amount <= 0) || _chosenDate == DateTime(1800)) {
      return;
    } else {
      widget.addTx(_title, _amount, _chosenDate);
      Navigator.of(context).pop();
    }
  }

  void _dateSelector() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _chosenDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          //padding: EdgeInsets.all(18.0),
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitIt(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitIt(),
              ),
              Container(
                height: 80.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_chosenDate == DateTime(1800)
                          ? 'No date selected'
                          : "Selected Date: ${DateFormat.yMEd().format(_chosenDate)}"),
                    ),
                    FlatButton(
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: _dateSelector,
                        child: Text(
                          'Select Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _submitIt();
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Add Entry'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
