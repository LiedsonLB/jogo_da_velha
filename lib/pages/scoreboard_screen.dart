import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:jogo_da_velha/components/card_score.dart';
import 'package:jogo_da_velha/services/database_service.dart';
import 'package:jogo_da_velha/UI/styles/styles.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({super.key});

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  List<Map<String, dynamic>> gameHistory = [];

  @override
  void initState() {
    super.initState();
    _loadGameHistory();
  }

  Future<void> _loadGameHistory() async {
    final history = await DatabaseService.instance.fetchGameHistory();
    setState(() {
      gameHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondary,
      appBar: AppBar(
        backgroundColor: MyColors.secondary,
        foregroundColor: MyColors.white,
        title: const Text(
          'Histórico de Partidas',
          style: TextStyle(
            color: MyColors.white,
            fontSize: 20.0,
            fontFamily: 'RussoOne',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // aqui vou dar um gap entre os itens
              itemCount: gameHistory.length,
              itemBuilder: (context, index) {
                final game = gameHistory[index];

                // Converte a data salva em string para DateTime
                final date = DateTime.parse(game['date']);

                return CardScore(
                  name: 'Ganhador: ${game['winner']}',
                  date: DateFormat('dd/MM/yyyy HH:mm').format(date),
                  mode: game['mode'],
                  boardState: game['boardState'].split(','),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
