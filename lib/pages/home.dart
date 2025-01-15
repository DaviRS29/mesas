import 'package:atomo/pages/config.dart';
import 'package:atomo/pages/home_control.dart';
import 'package:atomo/pages/user.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuButton(Icons.people, "USUÁRIOS", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => User()),
                  );
                }),
                _buildMenuButton(Icons.settings, "DEFINIÇÕES", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Config()),
                  );
                }),
                _buildMenuButton(Icons.person, "INICIAR", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeControl()),
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed, // Chama a função ao clicar no botão
      child: Card(
        color: Colors.blue[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
