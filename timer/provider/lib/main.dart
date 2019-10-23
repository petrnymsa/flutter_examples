import 'package:flutter/material.dart';
import 'package:flutter_timer_provider/ticker.dart';
import 'package:flutter_timer_provider/timer.dart';
import 'package:flutter_timer_provider/timer_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      title: 'Flutter Timer',
      home: ChangeNotifierProvider(
        //* Provides provider to child
        builder: (context) => TimerProvider(ticker: Ticker()),
        child: Timer(),
      ),
    );
  }
}
