import 'package:flutter/material.dart';
import 'pages/cronometro_page.dart';
import 'pages/my_home_page.dart';
import 'pages/finished_cronometros_page.dart'; // Adicionando a importação

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/cronometro': (context) => CronometroPage(),
        '/finishedCronometros': (context) => FinishedCronometrosPage(), // Adicionando a rota
      },
    );
  }
}
