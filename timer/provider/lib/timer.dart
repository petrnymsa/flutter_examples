import 'package:flutter/material.dart';
import 'package:flutter_timer_provider/timer_provider.dart';
import 'package:provider/provider.dart';
import './actions.dart' as ac;
import 'background.dart';

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    print('Rebuild scaffold');
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Timer')),
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(
                  child: Consumer<TimerProvider>(
                    builder: (context, state, child) {
                      print('Rebuild timer');
                      final String minutesStr = ((state.duration / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      final String secondsStr = (state.duration % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      return Text(
                        '$minutesStr:$secondsStr',
                        style: Timer.timerTextStyle,
                      );
                    },
                  ),
                ),
              ),
              Selector<TimerProvider, TimerState>(
                //* Rebuild only when state really changed to another value
                selector: (_, provider) => provider.state,
                builder: (ctx, state, _) => ac.Actions(state),
              ),
              // Consumer<TimerProvider>(
              //! just Consumer is not enough - will  rebuild every time when duration change
              //   builder: (_, provider, child) => ac.Actions(provider.state),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
