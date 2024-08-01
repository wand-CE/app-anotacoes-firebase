import 'package:aplicativo_anotacoes_firebase/database/operationsFirebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AppRoutes.dart';
import '../components/showAlertDialog.dart';

class EditNotePage extends StatefulWidget {
  final String idNote;

  const EditNotePage({super.key, required this.idNote});

  @override
  State<EditNotePage> createState() => _EditPageState();
}

class _EditPageState extends State<EditNotePage> {
  static DatabaseOperationsFirebase firebaseInstance =
      DatabaseOperationsFirebase();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String idNote = widget.idNote;

    TextEditingController _controllerNoteTitle = TextEditingController();
    TextEditingController _controllerNoteText = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Editando Anotação'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.homePage),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ShowAlertDialog(
                    title: Text('Excluir Nota'),
                    content: Text(
                      'Tem certeza que deseja excluir essa anotação?',
                    ),
                    yesAnswer: 'Sim',
                    alertAction: () async {
                      await firebaseInstance.removeNote(idNote);
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.homePage);
                    },
                  );
                },
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: firebaseInstance.returnDataNote(widget.idNote),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            var data = snapshot.data!;
            _controllerNoteTitle.text = data['title'] ?? '';
            _controllerNoteText.text = data['text'] ?? '';
            return Column(
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
                            value = value?.trim();

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
                              value = value?.trim();

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
            );
          } else {
            return Text('');
          }
        },
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            firebaseInstance.editAnotacao(
              idNote,
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
        child: Text("Alterar"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
