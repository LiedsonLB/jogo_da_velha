import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

import 'package:jogo_da_velha/UI/button_design.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JOGO DA IDOSA',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void playWithPlayer() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameScreen(vsCpu: false)),
      );
    }

    void playWithCpu() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameScreen(vsCpu: true)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        title: Text(
          'JOGO DA IDOSA',
          style: TextStyle(color: Colors.grey[50]),
        ),
        backgroundColor: Colors.green[900],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('lib/img/icon.png'),
              height: 200,
            ),
            const SizedBox(height: 20),
            ButtonDesign(
                name: 'Jogar contra Jogador',
                onPressed: playWithPlayer,
                secondaryColor: false),
            const SizedBox(height: 20),
            ButtonDesign(
                name: 'Jogar contra CPU',
                onPressed: playWithCpu,
                secondaryColor: true),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final bool vsCpu;

  GameScreen({required this.vsCpu});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  bool gameOver = false;
  String result = '';

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      gameOver = false;
      result = '';
    });
  }

  void makeMove(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        checkWinner();
        if (!gameOver) {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          if (widget.vsCpu && currentPlayer == 'O') {
            cpuMove();
          }
        }
      });
    }
  }

  void cpuMove() {
    List<int> emptyIndices = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') emptyIndices.add(i);
    }
    if (emptyIndices.isNotEmpty) {
      int randomIndex = emptyIndices[Random().nextInt(emptyIndices.length)];
      makeMove(randomIndex);
    }
  }

  void checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        setState(() {
          gameOver = true;
          result = '${board[pattern[0]]} venceu!';
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        gameOver = true;
        result = 'Empate!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar:
          AppBar(title: Text(widget.vsCpu ? 'Jogador vs CPU' : '2 Jogadores')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gameOver
              ? Column(
                  children: [
                    Text(
                      result,
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: resetGame,
                      child: Text('Recomeçar'),
                    ),
                  ],
                )
              : Text(
                  'Vez de: $currentPlayer',
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => makeMove(index),
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
