class Cronometro {
  final int? id;
  final int counter;
  final bool isRunning;
  final bool isFinished;
  final bool isPaused;

  Cronometro({
    this.id,
    required this.counter,
    required this.isRunning,
    required this.isFinished,
    required this.isPaused,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'counter': counter,
      'is_running': isRunning ? 1 : 0,
      'is_finished': isFinished ? 1 : 0,
      'is_paused': isPaused ? 1 : 0,
    };
  }
}
