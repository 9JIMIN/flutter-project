import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    // get의 정확한 의미가 궁금.
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    setState(() {
      _userTransactions.add(Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString(),
      ));
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      // context는 Navigator, Theme같은거를 참고하기 위해 필요하다.
      // 위젯트리에 들어가고, 나가는 거니까, context가 있어야하지.
      builder: (_) {
        // builder는 showModalBottomSheet에 넣을 위젯을 리턴한다.
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  // build내부에 정의되는 변수들은 Context를 이용하는 위짓들.
  // state에서 정의되는거랑, build에서 정의되는거랑 차이점.

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: GestureDetector(
              // 여기에 원래는 Row가 있었는데 왜??
              child: Icon(CupertinoIcons.add),
              onTap: () => _startAddNewTransaction(context),
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final fullHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final txListWidget = Container(
      height: fullHeight * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final pageBody = SafeArea(
      // 동그란 엣지에서 화면 안 짤리게 해줌.
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Column(
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    // 플랫폼에 맞는 스위치를 생성해서 adaptive
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: fullHeight * 0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
            if (!isLandscape)
              Container(
                height: fullHeight * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }
}
