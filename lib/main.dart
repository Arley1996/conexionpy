import 'dart:convert';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List producto = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8080/producto'));

    if (response.statusCode == 200) {
      setState(() {
        producto = json.decode(response.body);
      });
    } else {
      throw Exception('Error al cargar los productos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('producto'),
      ),
      body: ListView.builder(
        itemCount: producto.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${producto[index]['nombre_producto']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Codigo: ${producto[index]['codigo']}'),
                Text('Precio: \$${producto[index]['precio']}'),
                Text('Descripcion: ${producto[index]['descripcion']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
