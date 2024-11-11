import 'dart:math';
import 'package:jogo_da_velha/services/database_service.dart';

class GameLogic {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  bool gameOver = false;
  String result = '';
  final DatabaseService databaseService;

  GameLogic(this.databaseService);

  void resetGame() {
    board = List.filled(9, '');
    currentPlayer = 'X';
    gameOver = false;
    result = '';
  }

  void makeMove(int index, bool vsCpu) {
    if (board[index] == '' && !gameOver) {
      board[index] = currentPlayer;
      checkWinner();
      if (!gameOver) {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        if (vsCpu && currentPlayer == 'O') {
          cpuMove();
        }
      }
    }
  }

  void cpuMove() {
    List<int> emptyIndices = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') emptyIndices.add(i);
    }
    if (emptyIndices.isNotEmpty) {
      int randomIndex = emptyIndices[Random().nextInt(emptyIndices.length)];
      makeMove(randomIndex, false);
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
        gameOver = true;
        result = 'Jogador ${board[pattern[0]]} venceu!';
        saveGameResult(board[pattern[0]]);
        return;
      }
    }

    if (!board.contains('')) {
      gameOver = true;
      result = 'Empate!';
      saveGameResult('Empate');
    }
  }

  // Função para salvar o jogo no banco de dados
  Future<void> saveGameResult(String winner) async {
    String boardState = board.join(',');
    String mode = currentPlayer == 'X' ? 'cpu' : '2 Jogadores';

    await databaseService.saveGame(winner, mode, boardState);
  }
}