import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepository {
  final String baseUrl = 'http://192.168.15.15:5000';

  // Método para buscar a quantidade de mesas
  Future<int> fetchQuantidadeMesas() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/quantidade'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'].isNotEmpty) {
          return int.parse(data['data'][0]['SENHA']);
        } else {
          throw Exception('Nenhum dado encontrado');
        }
      } else {
        throw Exception('Erro ao carregar quantidade: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }

  // Método para buscar mesas
  Future<List<Map<String, dynamic>>> fetchMesas() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/comandas'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Erro ao carregar mesas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }


  // Método para buscar produtos
  Future<List<Map<String, dynamic>>> fetchProdutos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/produtos'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Erro ao carregar os produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }

  // Método para buscar itens de mesas
  Future<List<Map<String, dynamic>>> fetchItensMesas() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/comandas_itens'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Erro ao carregar os itens das mesas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }
}
