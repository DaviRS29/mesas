import 'package:atomo/pages/mesa_itens.dart';
import 'package:atomo/repositorio/api_repositorio.dart';
import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  final ApiRepository api = ApiRepository();
  int quantidadeMesas = 0;
  List<dynamic> mesasOcupadas = []; // Lista de mesas ocupadas
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDados(); // Carrega todas as informações
  }

  Future<void> _loadDados() async {
    try {
      final mesasOcupadasFuture = api.fetchMesas(); // Busca mesas ocupadas
      final quantidadeMesasFuture =
          api.fetchQuantidadeMesas(); // Busca quantidade de mesas

      // Aguarda ambas as funções terminarem
      final resultados =
          await Future.wait([mesasOcupadasFuture, quantidadeMesasFuture]);

      setState(() {
        mesasOcupadas =
            resultados[0] as List<dynamic>; // Define as mesas ocupadas
        quantidadeMesas = resultados[1] as int;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('dasda')),
        );

        isLoading = false; // Finaliza o carregamento
      });
    } catch (e) {

      setState(() {
        isLoading = false; // Finaliza o carregamento em caso de erro
      });
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Erro: $e   \n$mesasOcupadas\n$quantidadeMesas')),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesas'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Indicador de carregamento
          : GridView.count(
              crossAxisCount: 3,
              // Número fixo de colunas
              crossAxisSpacing: 10,
              // Espaçamento horizontal
              mainAxisSpacing: 10,
              // Espaçamento vertical
              padding: const EdgeInsets.all(10),
              // Espaçamento ao redor da grade
              children: List.generate(quantidadeMesas, (index) {
                final numeroMesa = index + 1;
                final estaOcupada =
                    mesasOcupadas.any((mesa) => mesa['MESA'] == numeroMesa);

                return GestureDetector(
                  onTap: () {
                    int? codigo; // Declarando a variável como nullable

                    for (var mesas in mesasOcupadas) {
                      if (mesas['MESA'] == numeroMesa) {
                        codigo = mesas['CODIGO'];
                        break;// Sai do loop quando encontra a mesa
                      }
                    }
                    Navigator.push(
                     context, MaterialPageRoute(builder: (context) => MesaItens(codigo: codigo))
                    );
                    print(codigo);
                    print('Mesa $numeroMesa selecionada');
                    print(
                        'Mesa $numeroMesa ${estaOcupada ? "Ocupada" : "Livre"} selecionada');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: estaOcupada ? Colors.redAccent : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Mesa $numeroMesa',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
