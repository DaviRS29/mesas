import 'package:atomo/pages/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MeuAplicativo());
}
class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.red,
          primaryColorDark: Colors.red,
          primaryColorLight: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Home(),
    );
  }
}
