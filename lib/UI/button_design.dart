import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool secondaryColor;

  const ButtonDesign(
      {super.key,
      required this.name,
      required this.onPressed,
      required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(250, 50)),
        backgroundColor: secondaryColor
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.indigo),
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: secondaryColor ? Colors.indigo : Colors.white,
        ),
      ),
    );
  }
}
