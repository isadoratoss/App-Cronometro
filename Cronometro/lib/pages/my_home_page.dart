import 'package:flutter/material.dart';
import '../dao/cronometro_dao.dart';
import '../model/cronometro.dart';
import 'cronometro_page.dart';
import 'finished_cronometros_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final CronometroDAO _cronometroDAO;
  List<Cronometro> _cronometros = [];

  @override
  void initState() {
    super.initState();
    _cronometroDAO = CronometroDAO.instance;
    _loadCronometros();
  }

  void _loadCronometros() async {
    final cronometros = await _cronometroDAO.getFinishedCronometros();
    setState(() {
      _cronometros = cronometros;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CronometroPage()),
                );
              },
              child: Text('Iniciar Cronômetro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinishedCronometrosPage()),
                );
              },
              child: Text('Histórico'),
            ),
          ],
        ),
      ),
    );
  }
}
