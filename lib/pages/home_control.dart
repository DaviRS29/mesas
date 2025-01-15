import 'package:atomo/pages/dark.dart';
import 'package:atomo/pages/salao.dart';
import 'package:flutter/material.dart';

class HomeControl extends StatelessWidget {
  const HomeControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(

          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Teste()));
          },
          child: Container(

            width: 100, // Largura do quadrado
            height: 100, // Altura do quadrado
            color: Colors.blue, // Cor de fundo
            child: Center(
              child: Text(
                'Mesas',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
