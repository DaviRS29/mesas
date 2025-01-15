import 'package:atomo/repositorio/api_repositorio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MesaItens extends StatefulWidget {
  final int? codigo; // Adiciona o campo para o código

  // Modifica o construtor para receber o código
  const MesaItens({super.key, required this.codigo});

  @override
  State<MesaItens> createState() => _MesaItensState();
}

class _MesaItensState extends State<MesaItens> {
  List<dynamic> itenslist = [];
  List<dynamic> tabela_itens_mesa = [];
  final ApiRepository api = ApiRepository();
  bool isLoading = true;

  final currencyFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    print('Código recebido: ${widget.codigo}'); // Acessa o código passado
    _dados();
  }

  Future<void> _dados() async {
    try {
      final tabela_itens_mesa =
          await api.fetchItensMesas(); // Aguarda a API retornar os dados

      setState(() {
        itenslist = tabela_itens_mesa
            .where((item) => item['CODIGO'] == widget.codigo)
            .toList(); // Armazena os itens no estado
        print(itenslist);
        isLoading = false; // Finaliza o carregamento
      });
    } catch (e) {
      print('Erro ao carregar dados: $e');
      setState(() {
        isLoading = false; // Finaliza o carregamento mesmo em caso de erro
      });
    }
  }

  double _subtotal() {
    return itenslist.fold(
      0.0,
      (total, item) => total + item['VLR_TOTAL'],
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('COMANDA'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_,__)=> Divider(),
                    itemCount: itenslist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(itenslist[index]['DESCRICAO']),
                        subtitle: Row(
                          children: [
                            Text('Quant. ${itenslist[index]['QTDE']}'),
                            Spacer(),
                            Text(
                              currencyFormatter
                                  .format(itenslist[index]['VLR_UNIT']),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    },


                  ),
                ),
                Container(
                  color: Colors.blue[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          currencyFormatter.format(_subtotal()),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
