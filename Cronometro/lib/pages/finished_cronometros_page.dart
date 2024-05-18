import 'package:flutter/material.dart';
import '../dao/cronometro_dao.dart';
import '../model/cronometro.dart';

class FinishedCronometrosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetros Finalizados'),
      ),
      body: FutureBuilder<List<Cronometro>>(
        future: CronometroDAO.instance.getFinishedCronometros(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum cronômetro finalizado.'));
          } else {
            final cronometros = snapshot.data!;
            return ListView.builder(
              itemCount: cronometros.length,
              itemBuilder: (context, index) {
                final cronometro = cronometros[index];
                return ListTile(
                  title: Text('Cronômetro'),
                  subtitle: Text('Contador: ${cronometro.counter}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
