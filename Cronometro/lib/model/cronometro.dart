import 'dart:async';

class Cronometro {
  int _counter = 0;
  bool _isRunning = false;
  late Timer _timer;
  final StreamController<int> _controller = StreamController<int>();

  Stream<int> get onUpdate => _controller.stream;

  bool get isRunning => _isRunning;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;
      _controller.add(_counter);
    });
    _isRunning = true;
  }

  void stopTimer() {
    _timer.cancel();
    _isRunning = false;
  }

  void resetTimer() {
    _timer.cancel();
    _counter = 0;
    _isRunning = false;
    _controller.add(_counter);
  }

  void dispose() {
    _controller.close();
  }
}
