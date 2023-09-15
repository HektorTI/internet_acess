import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Adicione o parâmetro key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const PrevisaoDoTempo(),
    );
  }
}

class PrevisaoDoTempo extends StatefulWidget {
  const PrevisaoDoTempo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PrevisaoDoTempoState createState() => _PrevisaoDoTempoState();
}

class _PrevisaoDoTempoState extends State<PrevisaoDoTempo> {
  String apiKey = 'd62cac6d7fe423e36b7c0960418f5cc3'; //  chave de API
  String city = 'Sao Paulo'; // cidade
  String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=Sao%20Paulo,BR&appid=d62cac6d7fe423e36b7c0960418f5cc3&units=metric';

  Map<String, dynamic> previsaoDotempo = {};

  int umidade = 0;

  @override
  void initState() {
    super.initState();
    buscarDadosOpenWeather();
  }

  Future<void> buscarDadosOpenWeather() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        previsaoDotempo = data;
        umidade = previsaoDotempo['main']['humidity']; // Armazena a umidade
      });
    } else {
      throw Exception('Falha ao carregar dados meteorológicos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsão do Tempo'),
        backgroundColor: const Color.fromARGB(255, 122, 120, 112),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.red],
          ),
        ),
        child: Center(
          child: previsaoDotempo.isEmpty
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _climaIcones(),
                    Text(
                      'Cidade: ${previsaoDotempo['name']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Temperatura: ${previsaoDotempo['main']['temp']}°C',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Condição: ${previsaoDotempo['weather'][0]['description']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Umidade: $umidade%',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _climaIcones() {
    String iconCode = previsaoDotempo['weather'][0]['main'];

    switch (iconCode) {
      case 'Clear':
        return const Icon(Icons.wb_sunny, size: 100, color: Colors.yellow);
      case 'Clouds':
        return const Icon(Icons.cloud, size: 100, color: Colors.grey);
      case 'Rain':
        return const Icon(Icons.beach_access, size: 100, color: Colors.blue);
      case 'Snow':
        return const Icon(Icons.ac_unit, size: 100, color: Colors.white);
      default:
        return const Icon(Icons.wb_sunny, size: 100, color: Colors.yellow);
    }
  }
}
