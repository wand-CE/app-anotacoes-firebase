import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String campo;
  final TextEditingController controlador;
  final TextInputType tipoInput;

  const CustomTextFormField({
    super.key,
    required this.campo,
    required this.controlador,
    this.tipoInput = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      style: TextStyle(
        decorationThickness: 0,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: tipoInput,
      decoration: InputDecoration(
        labelText: '$campo',
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
