import 'package:flutter/material.dart';
import 'package:jogo_da_velha/components/button_design.dart';
import 'package:jogo_da_velha/UI/styles/styles.dart';

class ModalGame extends StatelessWidget {
  final String winner;
  final Function resetGame;

  const ModalGame({super.key, required this.winner, required this.resetGame});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        constraints: const BoxConstraints(maxHeight: 300),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('lib/UI/img/trophy.png'),
                height: 80,
              ),
              const SizedBox(height: 20),
              Text(
                winner,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'RussoOne',
                  fontWeight: FontWeight.bold,
                  color: MyColors.secondary,
                ),
              ),
              const SizedBox(height: 30),
              ButtonDesign (
                name: 'Recomeçar',
                onPressed: () {
                  resetGame();
                  Navigator.pop(context);
                },
                secondaryColor: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
