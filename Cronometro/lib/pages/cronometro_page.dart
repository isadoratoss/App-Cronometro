import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../dao/cronometro_dao.dart';
import '../model/cronometro.dart';
import '../state/cronometro_state.dart';
import 'finished_cronometros_page.dart';

class CronometroPage extends StatefulWidget {
  @override
  _CronometroPageState createState() => _CronometroPageState();
}

class _CronometroPageState extends State<CronometroPage> {
  Timer? _timer;
  bool _isRunning = false;
  late final CronometroDAO _cronometroDAO;

  @override
  void initState() {
    super.initState();
    _cronometroDAO = CronometroDAO.instance;
  }

  void _startStopCronometro() {
    if (_isRunning) {
      _pauseCronometro();
    } else {
      _startCronometro();
    }
  }

  void _startCronometro() {
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      Provider.of<CronometroState>(context, listen: false).increment();
    });
  }

  void _pauseCronometro() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
    _saveCronometro(isFinished: false);
  }

  void _resetCronometro() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
    Provider.of<CronometroState>(context, listen: false).reset();
    _saveCronometro(isFinished: true);
  }

  Future<void> _saveCronometro({required bool isFinished}) async {
    final cronometroState = Provider.of<CronometroState>(context, listen: false);
    final cronometro = Cronometro(
      id: null,
      counter: cronometroState.counter,
      isRunning: _isRunning,
      isFinished: isFinished,
      isPaused: !_isRunning && !isFinished,
    );

    await _cronometroDAO.insertCronometro(cronometro);
  }

  void _showFinishedCronometros() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FinishedCronometrosPage()),
    );
  }

  void _finishCronometro() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
    _saveCronometro(isFinished: true);
    _showFinishedCronometros();
  }

  @override
  Widget build(BuildContext context) {
    final cronometroState = Provider.of<CronometroState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${cronometroState.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _startStopCronometro,
                  tooltip: _isRunning ? 'Parar' : 'Iniciar',
                  child: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _resetCronometro,
                  tooltip: 'Zerar',
                  child: Icon(Icons.stop),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _finishCronometro,
                  tooltip: 'Finalizar',
                  child: Icon(Icons.flag),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showFinishedCronometros,
              child: Text('Histórico'),
            ),
          ],
        ),
      ),
    );
  }
}
