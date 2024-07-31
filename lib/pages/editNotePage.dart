import 'package:aplicativo_anotacoes_firebase/database/operationsFirebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AppRoutes.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, required String id_note});

  get id_note => id_note;

  @override
  State<EditNotePage> createState() => _EditPageState();
}

class _EditPageState extends State<EditNotePage> {
  var id_note;

  TextEditingController _controller_note_title = TextEditingController();
  TextEditingController _controller_note_text = TextEditingController();

  @override
  void initState() {
    super.initState();
    id_note = widget.id_note;
  }

  @override
  Widget build(BuildContext context) {
    Future<Object> listaDados =
        DatabaseOperationsFirebase().returnDataNote(context, id_note);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editando Anotação'),
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
        onPressed: () {},
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
