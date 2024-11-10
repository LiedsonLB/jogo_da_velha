import 'package:flutter/material.dart';
import 'package:jogo_da_velha/components/button_design.dart';
import 'package:jogo_da_velha/UI/styles/styles.dart';
import 'package:jogo_da_velha/pages/game_screen.dart';
import 'package:jogo_da_velha/pages/scoreboard_screen.dart';

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

    void playHistorico() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScoreboardScreen()),
      );
    }

    return Scaffold(
      backgroundColor: MyColors.secondary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'JOGO DA IDOSA',
                style: TextStyle(
                  color: Colors.grey[50],
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RussoOne',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Image(
                image: AssetImage('lib/UI/img/icon.png'),
                height: 200,
              ),
              const SizedBox(height: 30),
              ButtonDesign(
                name: 'Jogar contra Jogador',
                onPressed: playWithPlayer,
                secondaryColor: false,
              ),
              const SizedBox(height: 10),
              ButtonDesign(
                name: 'Jogar contra CPU',
                onPressed: playWithCpu,
                secondaryColor: true,
              ),
              const SizedBox(height: 10),
              ButtonDesign(
                name: 'Historico',
                onPressed: playHistorico,
                secondaryColor: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
