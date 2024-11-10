import 'package:flutter/material.dart';
import 'package:jogo_da_velha/components/card_score.dart';
import 'package:jogo_da_velha/UI/styles/styles.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({super.key});

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
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
              itemCount: 60,
              itemBuilder: (context, index) => const ListTile(
                title: CardScore(name: 'Ganhador: X', date: '01/01/2021', mode: 'cpu', boardState: ['X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X']),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
