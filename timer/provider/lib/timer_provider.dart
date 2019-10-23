import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_timer_provider/ticker.dart';

enum TimerState { ready, running, paused, finished }

class TimerProvider with ChangeNotifier {
  final Ticker _ticker;

  static final int _defaultDuration = 60;

  int _duration = _defaultDuration;
  TimerState _state = TimerState.ready;
  StreamSubscription _tickerSubscription;

  TimerState get state => _state;
  int get duration => _duration;

  TimerProvider({Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  void start({int duration = 60}) {
    _setState(TimerState.running);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: duration).listen(tick);
  }

  void tick(int tick) {
    _duration = tick;
    _duration > 0
        ? _setState(TimerState.running)
        : _setState(TimerState.finished);
  }

  void pause() {
    if (_state == TimerState.running) {
      _tickerSubscription?.pause();
      _setState(TimerState.paused);
    }
  }

  void resume() {
    if (_state == TimerState.paused) {
      _tickerSubscription?.resume();
      _setState(TimerState.running);
    }
  }

  void reset() {
    _duration = _defaultDuration;
    _tickerSubscription?.cancel();
    _setState(TimerState.ready);
  }

  void _setState(TimerState state) {
    _state = state;
    notifyListeners();
  }
}
