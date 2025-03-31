import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);
  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa sorte!!!";
  int _pontosUsuario = 0;
  int _pontosApp = 0;
  int _empates = 0;
  Color _corResultado = Colors.black;

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];
    print("Escolha do App: " + escolhaApp);
    print("Escolha do Usuário: " + escolhaUsuario);

    // Exibir na UI o resultado da escolha do APP
    switch (escolhaApp) {
      case "pedra":
        setState(() {
          _imagemApp = AssetImage("images/pedra.png");
        });
        break;
      case "papel":
        setState(() {
          _imagemApp = AssetImage("images/papel.png");
        });
        break;
      case "tesoura":
        setState(() {
          _imagemApp = AssetImage("images/tesoura.png");
        });
        break;
    }

    // Lógica para ganhador e perdedor
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _resultadoFinal = "Parabéns!!! Você ganhou :)";
        _corResultado = Colors.blue;
        _pontosUsuario++;
      });
    } else if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      setState(() {
        _resultadoFinal = "Puxa!!! Você perdeu :(";
        _corResultado = Colors.red;
        _pontosApp++;
      });
    } else {
      setState(() {
        _resultadoFinal = "Empate!!! Tente novamente :/";
        _corResultado = Colors.orange;
        _empates++;
      });
    }
  }

  Widget _buildOpcaoJogo(String imagem, String nome) {
    return Column(
      children: [
        GestureDetector(
          onTap: () =>
              _opcaoSelecionada(imagem.split('/').last.split('.').first),
          child: Image(
            image: AssetImage(imagem),
            height: 100,
          ),
        ),
        SizedBox(height: 8),
        Text(
          nome,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('JokenPO'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Placar de pontos
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Você",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$_pontosUsuario",
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Empates",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$_empates",
                      style: TextStyle(fontSize: 24, color: Colors.orange),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "App",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$_pontosApp",
                      style: TextStyle(fontSize: 24, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //1 - Escolha do App
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          //2 - Imagem de escolha do app
          Image(image: _imagemApp),

          //3 - Escolha uma opção abaixo:
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha uma opção abaixo:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Opções do jogo com nomes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildOpcaoJogo('images/pedra.png', 'Pedra'),
              _buildOpcaoJogo('images/papel.png', 'Papel'),
              _buildOpcaoJogo('images/tesoura.png', 'Tesoura'),
            ],
          ),

          // Resultado com cor
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _resultadoFinal,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _corResultado,
              ),
            ),
          ),

          // Botão para reiniciar o jogo (melhoria de usabilidade)
          ElevatedButton(
            onPressed: () {
              setState(() {
                _imagemApp = AssetImage("images/padrao.png");
                _resultadoFinal = "Boa sorte!!!";
                _corResultado = Colors.black;
                _pontosUsuario = 0;
                _pontosApp = 0;
                _empates = 0;
              });
            },
            child: Text("Reiniciar Jogo"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
