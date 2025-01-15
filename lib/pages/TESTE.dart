import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(FirebirdApp());

class FirebirdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<dynamic> products = [];
  List<dynamic> cart = []; // Lista para armazenar os produtos no carrinho

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('http://192.168.15.15:5000/produtos');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product); // Adiciona o produto ao carrinho
    });
  }

  void viewCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen(cart: cart)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: viewCart, // Visualizar o carrinho
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['DESCRICAO']),
            subtitle: Text('Preço: R\$${product['PRC_VENDA']}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () => addToCart(product), // Adicionar ao carrinho
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<dynamic> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    double total = cart.fold(
      0.0,
          (sum, product) => sum + (product['PRC_VENDA'] as num),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: cart.isEmpty
          ? Center(child: Text('O carrinho está vazio!'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return ListTile(
                  title: Text(product['DESCRICAO']),
                  subtitle: Text('Preço: R\$${product['PRC_VENDA']}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: R\$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
