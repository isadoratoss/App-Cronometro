import 'package:flutter/material.dart';
import '../model/cronometro.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Cronometro _cronometro = Cronometro();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              stream: _cronometro.onUpdate,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data} segundos',
                  style: TextStyle(fontSize: 40),
                );
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    if (!_cronometro.isRunning) {
                      _cronometro.startTimer();
                    } else {
                      _cronometro.stopTimer();
                    }
                    setState(() {});
                  },
                  child: _cronometro.isRunning
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    _cronometro.resetTimer();
                    setState(() {});
                  },
                  child: Icon(Icons.stop),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cronometro.dispose();
    super.dispose();
  }
}
