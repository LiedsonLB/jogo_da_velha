import 'package:flutter/material.dart';
import 'package:jogo_da_velha/UI/styles/styles.dart';

class CardScore extends StatelessWidget {
  final String name;
  final String date;
  final String mode;
  final List<String> boardState;

  const CardScore({
    super.key,
    required this.name,
    required this.date,
    required this.mode,
    required this.boardState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.secondary,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('lib/UI/img/trophy.png'),
              height: 20,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Data: $date',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            mode == 'cpu' ? const Icon(
              Icons.computer,
              color: MyColors.secondary,
            ) : const Icon(
              Icons.people,
              color: MyColors.secondary,
            ),
            const SizedBox(width: 20),
            _buildMiniBoard(),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBoard() {
    return Column(
      children: List.generate(3, (row) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: Row(
          children: List.generate(3, (col) {
            final index = row * 3 + col;
            return Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                boardState[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: boardState[index] == 'X'
                      ? MyColors.blue
                      : boardState[index] == 'O'
                      ? MyColors.red
                      : MyColors.white,
                ),
              ),
            );
          }),
        ),);
      }),
    );
  }
}