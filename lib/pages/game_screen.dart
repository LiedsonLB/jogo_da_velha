import 'package:flutter/material.dart';
import 'package:jogo_da_velha/UI/styles/styles.dart';
import 'package:jogo_da_velha/components/modal.dart';
import 'package:jogo_da_velha/controllers/game_controller.dart';
import 'package:jogo_da_velha/services/database_service.dart';

class GameScreen extends StatefulWidget {
  final bool vsCpu;

  GameScreen({required this.vsCpu});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameLogic gameLogic;
  late DatabaseService databaseService;

  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService();
    gameLogic = GameLogic(databaseService);
  }

  void resetGame() {
    setState(() {
      gameLogic.resetGame();
      gameLogic.gameOver = false;
    });
  }

  void makeMove(int index) {
    setState(() {
      gameLogic.makeMove(index, widget.vsCpu);
      if (gameLogic.gameOver) {
        gameResult();
      }
    });
  }

  void gameResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalGame(
          winner: gameLogic.result,
          resetGame: resetGame,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondary,
      appBar: AppBar(
        title: Text(
          widget.vsCpu ? 'Jogador vs CPU' : '2 Jogadores',
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'RussoOne',
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
        backgroundColor: MyColors.secondary,
        foregroundColor: MyColors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rodada do Jogador ${gameLogic.currentPlayer}',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'RussoOne',
                fontWeight: FontWeight.bold,
                color: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 20),
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
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        gameLogic.board[index],
                        style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'RussoOne',
                          fontWeight: FontWeight.bold,
                          color: gameLogic.board[index] == 'X'
                              ? MyColors.blue
                              : MyColors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// enviar o gameLogic.board para o historico para criar uma cena do tabuleiro, além do ganhador, tipo de modo e data da partida
