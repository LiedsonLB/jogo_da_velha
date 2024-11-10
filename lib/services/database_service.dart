import 'package:postgres/postgres.dart';

class DatabaseService {
  late Connection connection;

  // Conectando o banco de dados
  Future<void> connect() async {
    try {
      connection = await Connection.open(
        Endpoint(
          host: 'localhost',
          database: 'jvbd',
          username: 'jvbd',
          password: 'password',
        ),
      );
      print('Conectado ao banco de dados PostgreSQL');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
  }

  // Função para salvar um jogo no banco de dados
  Future<void> saveGame(String winner, String mode, String boardState) async {
    try {
      await connection.execute(
        '''
        INSERT INTO game_history (winner, mode, board_state)
        VALUES (@winner, @mode, @boardState)
        ''',
        parameters: {
          'winner': winner,
          'mode': mode,
          'boardState': boardState,
        },
      );
      print('Jogo salvo com sucesso');
    } catch (e) {
      print('Erro ao salvar o jogo: $e');
    }
  }

  // Função para buscar o histórico de jogos
  Future<List<Game>> fetchGameHistory() async {
    try {
      List<List<dynamic>> results = await connection.execute('SELECT * FROM game_history');

      return results.map((row) {
        return Game(
          id: row[0],
          winner: row[1],
          date: row[2].toString(),
          mode: row[3],
          boardState: row[4].toString().split(','), // Para converter o tabuleiro para uma lista
        );
      }).toList();
    } catch (e) {
      print('Erro ao buscar histórico de jogos: $e');
      return [];
    }
  }

  // Função para fechar a conexão com o banco de dados
  Future<void> closeConnection() async {
    await connection.close();
    print('Conexão com o banco de dados fechada');
  }
}

// Classe para representar o modelo de um jogo
class Game {
  final int id;
  final String winner;
  final String date;
  final String mode;
  final List<String> boardState;

  Game({
    required this.id,
    required this.winner,
    required this.date,
    required this.mode,
    required this.boardState,
  });
}
