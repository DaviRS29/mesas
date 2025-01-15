import 'package:atomo/modelos/itens_mesa.dart';
import 'package:flutter/material.dart';

class Mesa {
  int numero;
  String status;
  int codigo;
  int vlr_total;
  List <ItensMesa> itensmesas = [];

  Mesa({
    required this.numero,
    required this.codigo,
    required this.status,
    required this.vlr_total,
  });
}
