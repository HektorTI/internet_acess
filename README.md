# internet_acess

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Explicacao do app: 

Este código é um aplicativo Flutter que exibe a previsão do tempo para uma cidade específica usando a API OpenWeatherMap.

# Importação de pacotes:
Primeiro, fiz a importação dos pacotes convert, material, e http.

# Função principal (main()):
Em seguida, na função main, instanciei a classe MyApp.

# Classe MyApp:
Estendi a classe MyApp a partir da classe StatelessWidget, criando a parte estática, e no método build, criei um MaterialApp, que é o widget raiz do aplicativo, definindo home como a página de "Previsão do Tempo".

# Classe PrevisaoDoTempo:
Na classe PrevisaoDoTempo, criei uma extensão StatefulWidget que representa a tela principal do aplicativo.

# Classe _PrevisaoDoTempoState e Variáveis de estado:
Em seguida, criei a classe _PrevisaoDoTempoState, que é a classe de estado para a PrevisaoDoTempo. Dentro dela, declarei variáveis para armazenar a chave da API, a cidade, a URL da API e os dados de previsão do tempo e umidade.

# Método initState():
Na anotação @override, criei um método especial chamado quando o widget é criado. Ele chama buscarDadosOpenWeather() para buscar os dados da previsão do tempo assim que a tela é carregada.

# Método buscarDadosOpenWeather():
Este método verifica a solicitação HttpGet para a API do OpenWeather usando a URL especificada e obtém os dados. Se a resposta HTTP retornar o código de status 200 (tudo OK), então decodifica a resposta JSON e atualiza o estado com os dados de previsão do tempo e umidade que foram previamente declarados.

# Método build():
Dentro do método build, que está na classe de estado _PrevisaoDoTempoState, criamos a estrutura do aplicativo utilizando Scaffold, AppBar, e um Container no corpo, onde aplicamos um BoxDecoration com cores em gradiente. Se a previsão do tempo estiver vazia, exibe o widget CircularProgressIndicator, caso contrário, exibe a previsão do tempo e chama o método _climaIcones() para exibir um ícone correspondente às condições climáticas.

# Método _climaIcones():
O método _climaIcones() retorna um widget de ícone com base no código de ícone da condição climática. Ele utiliza um switch para mapear os diferentes códigos de ícone para ícones correspondentes.

O aplicativo Flutter busca a previsão do tempo de uma cidade usando a API OpenWeatherMap e exibe as informações na tela, incluindo um ícone correspondente à condição climática atual.

![Screenshot 2023-09-20 at 01 44 22](https://github.com/HektorTI/internet_acess/assets/142464152/11ebc87b-4279-4739-8df2-27d73d7213a7)

