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
  TextEditingController _controller_note_title = TextEditingController();
  TextEditingController _controller_note_text = TextEditingController();

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
            child: Column(
              children: [
                TextFormField(
                  controller: _controller_note_title,
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
                    controller: _controller_note_text,
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
          )
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          DatabaseOperationsFirebase().addAnotacao(
            context,
            _controller_note_title.text,
            _controller_note_text.text,
          );
          print('ola');
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
        ),
        child: Text("Adicionar/Alterar"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
