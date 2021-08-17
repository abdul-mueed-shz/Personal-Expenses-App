import 'package:flutter/material.dart';
import 'package:personalexpenseapp/models/tx.dart';
import 'package:personalexpenseapp/services/datachart.dart';
import 'package:personalexpenseapp/services/newtx.dart';
import 'package:personalexpenseapp/services/txlist.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Data
  final List<Transx> _usertx = [];
  bool _displayChart = false;
  //serviceFunctions
  List<Transx> get _recentweekTransx {
    return _usertx
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
    //as List<Transx>;
  }

  void _getAddTransx(BuildContext smbsContext) {
    showModalBottomSheet(
        context: smbsContext,
        builder: (builderContext) {
          return NewTx(addTx: _AddUserTx);
        });
  }

  void _AddUserTx(String Title, double Amount, DateTime chosenDate) {
    final newTx = Transx(
        ID: DateTime.now().toString(),
        title: Title,
        amount: Amount,
        date: chosenDate);
    setState(() {
      _usertx.add(newTx);
    });
  }

  void _removeUserTx(String id) {
    setState(() {
      _usertx.removeWhere((value) {
        return value.ID == id;
      });
    });
  }

  //Build Function
  @override
  Widget build(BuildContext context) {
    final mediaQueryVar = MediaQuery.of(context);
    final landscapeMode = mediaQueryVar.orientation == Orientation.landscape;
    final Appbar = AppBar(
      title: Text(
        'Xpense',
        style: TextStyle(
          fontFamily: 'opensans',
        ), //fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              _getAddTransx(context);
            },
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.white,
            ))
      ],
    );
    final transXListWidget = Container(
        height: (mediaQueryVar.size.height -
                Appbar.preferredSize.height -
                mediaQueryVar.padding.top) *
            0.65,
        child: TxList(transactions: _usertx, removeTransaction: _removeUserTx));
    return Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _getAddTransx(context);
            },
            backgroundColor: Colors.cyan,
            child: Icon(
              Icons.add,
            )),
        appBar: Appbar,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (landscapeMode)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Show Chart'),
                      Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: _displayChart,
                        onChanged: (value) {
                          setState(() {
                            _displayChart = value;
                          });
                        },
                      ),
                    ],
                  ),
                if (landscapeMode)
                  _displayChart
                      ? Container(
                          height: (mediaQueryVar.size.height -
                                  Appbar.preferredSize.height -
                                  mediaQueryVar.padding.top) *
                              0.8,
                          child: Chart(allweektransactions: _recentweekTransx))
                      : transXListWidget,
                if (!landscapeMode)
                  Container(
                      height: (mediaQueryVar.size.height -
                              Appbar.preferredSize.height -
                              mediaQueryVar.padding.top) *
                          0.35,
                      child: Chart(allweektransactions: _recentweekTransx)),
                if (!landscapeMode) transXListWidget,
              ],
            ),
          ),
        ));
  }
}
