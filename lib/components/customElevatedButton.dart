import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Icon icone;
  final Text textoLabel;
  final Function() buttonFunction;

  const CustomElevatedButton(
      {super.key,
      required this.icone,
      required this.textoLabel,
      required this.buttonFunction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Column(
        children: [icone, textoLabel],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      onPressed: buttonFunction,
    );
  }
}
