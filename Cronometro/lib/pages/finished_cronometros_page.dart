import 'package:flutter/material.dart';
import '../dao/cronometro_dao.dart';
import '../model/cronometro.dart';

class FinishedCronometrosPage extends StatefulWidget {
  const FinishedCronometrosPage({Key? key}) : super(key: key);

  @override
  _FinishedCronometrosPageState createState() => _FinishedCronometrosPageState();
}

class _FinishedCronometrosPageState extends State<FinishedCronometrosPage> {
  late final CronometroDAO _cronometroDAO;
  List<Cronometro> _cronometros = [];

  @override
  void initState() {
    super.initState();
    _cronometroDAO = CronometroDAO.instance;
    _loadFinishedCronometros();
  }

  void _loadFinishedCronometros() async {
    final cronometros = await _cronometroDAO.getFinishedCronometros();
    setState(() {
      _cronometros = cronometros;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetros Finalizados'),
      ),
      body: _buildCronometroList(),
    );
  }

  Widget _buildCronometroList() {
    if (_cronometros.isEmpty) {
      return Center(
        child: Text('Nenhum cronômetro finalizado'),
      );
    }

    return ListView.builder(
      itemCount: _cronometros.length,
      itemBuilder: (context, index) {
        final cronometro = _cronometros[index];
        return ListTile(
          title: Text('Cronômetro ${index + 1} - ${cronometro.counter} segundos'),
        );
      },
    );
  }
}
