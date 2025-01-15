import 'package:flutter/material.dart';

class Salao extends StatefulWidget {
  const Salao({super.key});

  @override
  State<Salao> createState() => _MesasState();
}

class _MesasState extends State<Salao> {
  int _mesasLinha = 3;
  final List<Map<String, String>> mesas = [
    {'numero': 'Mesa 1', 'status': 'Ocupada'},
    {'numero': 'Mesa 2', 'status': 'Livre'},
    {'numero': 'Mesa 3', 'status': 'Ocupada'},
    {'numero': 'Mesa 4', 'status': 'Livre'},
    {'numero': 'Mesa 5', 'status': 'Ocupada'},
    {'numero': 'Mesa 6', 'status': 'Livre'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesas'),
      ),
      body: GridView.count(
        crossAxisCount: _mesasLinha,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        children: mesas.map((mesa) {
          return GestureDetector(
            onTap: () {
              // Navega para a página de detalhes da mesa
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalhesMesa(mesa: mesa),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: mesa['status'] == 'Livre' ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  mesa['numero']!,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DetalhesMesa extends StatelessWidget {
  final Map<String, String> mesa;

  const DetalhesMesa({required this.mesa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mesa['numero']!),
      ),
      body: Center(
        child: Text(
          'Status: ${mesa['status']}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
