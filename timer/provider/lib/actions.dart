import 'package:flutter/material.dart';
import 'package:flutter_timer_provider/timer_provider.dart';
import 'package:provider/provider.dart';

class Actions extends StatelessWidget {
  final TimerState _state;

  Actions(this._state);

  @override
  Widget build(BuildContext context) {
    print('Build actions with state ${_state}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(context),
    );
  }

  List<Widget> _mapStateToActionButtons(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context, listen: false);
    if (_state == TimerState.ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => provider.start(),
        ),
      ];
    }
    if (_state == TimerState.running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => provider.pause(),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => provider.reset(),
        ),
      ];
    }
    if (_state == TimerState.paused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => provider.resume(),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => provider.reset(),
        ),
      ];
    }
    if (_state == TimerState.finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => provider.reset(),
        ),
      ];
    }
    return [];
  }
}
