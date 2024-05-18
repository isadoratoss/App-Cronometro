import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dao/cronometro_dao.dart';
import '../model/cronometro.dart';
import 'cronometro_page.dart';

class MyHomePage extends StatefulWidget {
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

  Future<void> _loadCronometros() async {
    List<Cronometro> cronometros = await _cronometroDAO.getFinishedCronometros();
    setState(() {
      _cronometros = cronometros;
    });
  }

  Future<void> _clearCronometros() async {
    await _cronometroDAO.clearCronometros();
    _loadCronometros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetros'),
      ),
      body: ListView.builder(
        itemCount: _cronometros.length,
        itemBuilder: (context, index) {
          final cronometro = _cronometros[index];
          return ListTile(
            title: Text('Cronômetro'),
            subtitle: Text('Contador: ${cronometro.counter}'),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CronometroPage()),
              ).then((_) => _loadCronometros());
            },
            tooltip: 'Novo Cronômetro',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _clearCronometros,
            tooltip: 'Limpar Histórico',
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
