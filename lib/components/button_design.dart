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
        minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 60)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        backgroundColor: secondaryColor
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.indigo),
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: secondaryColor ? Colors.indigo : Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
