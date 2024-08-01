import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AppRoutes.dart';
import '../database/operationsFirebase.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _NotePageState();
}

class _NotePageState extends State<AddNotePage> {
  TextEditingController _controllerNoteTitle = TextEditingController();
  TextEditingController _controllerNoteText = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Anotação'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.homePage),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerNoteTitle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo título não pode estar vazio';
                      }
                    },
                    decoration: InputDecoration(
                      label: const Text('Título'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    child: TextFormField(
                      controller: _controllerNoteText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo texto não pode estar vazio';
                        }
                      },
                      maxLines: 22,
                      decoration: InputDecoration(
                        label: const Text('Escreva sua anotação aqui'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            DatabaseOperationsFirebase().addAnotacao(
              _controllerNoteTitle.text,
              _controllerNoteText.text,
            );
            Navigator.pushReplacementNamed(context, AppRoutes.homePage);
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
        ),
        child: Text("Adicionar"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
