import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personalexpenseapp/pages/home.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        fontFamily: 'opensans',
        accentColor: Colors.blue.shade700,
        primarySwatch: Colors.cyan,
        //errorColor: ,
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'opensans',
                fontWeight: FontWeight.bold,
                fontSize: 17.0),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'georama',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)))),
    title: 'Xpense App',
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}
