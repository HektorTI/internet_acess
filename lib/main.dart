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
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key); // Adicione o parâmetro key

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey =
      '183bc01e95d9553494b168b73fa9d9ba'; // Substitua pela sua chave de API
  String city = 'Sao Paulo'; // Substitua pela sua cidade
  String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=Sao%20Paulo,BR&appid=183bc01e95d9553494b168b73fa9d9ba';

  Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        weatherData = data;
      });
    } else {
      throw Exception('Falha ao carregar dados meteorológicos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,

      appBar: AppBar(
        title: const Text('Previsão do Tempo'),
      ),
      body: Center(
        child: weatherData.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _getWeatherIcon(),
                  Text(
                    'Cidade: ${weatherData['name']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Temperatura: ${weatherData['main']['temp']}°C',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Condição: ${weatherData['weather'][0]['description']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _getWeatherIcon() {
    String iconCode = weatherData['weather'][0]['main'];

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
