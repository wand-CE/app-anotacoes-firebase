import 'dart:ffi';

import 'package:flutter/material.dart';

import '../AppRoutes.dart';
import '../components/customTextFormField.dart';
import '../components/showAlertDialog.dart';
import '../database/operationsFirebase.dart';
import 'editNotePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DatabaseOperationsFirebase firebaseInstance =
      DatabaseOperationsFirebase();
  final Future<List<dynamic>> _listaNotes = firebaseInstance.getNotes();

  List<dynamic> _idsAnotacoes = [];

  void changeMessage(indexMessage, newMessage) {
    setState(() {
      _idsAnotacoes[indexMessage] = newMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anotações'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
              onPressed: () {
                firebaseInstance.logOutUser();
                Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _listaNotes,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      String idNote = snapshot.data?[index]['id'];

                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey,
                        ),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text('${snapshot.data?[index]['title']}'),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                    builder: (context) => EditNotePage(
                                      idNote: idNote,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
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
                                          await firebaseInstance
                                              .removeNote(idNote);
                                          Navigator.pushReplacementNamed(
                                              context, AppRoutes.homePage);
                                        });
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
                      );
                    },
                    itemCount: snapshot.data?.length,
                    scrollDirection: Axis.vertical,
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 175), // Espaçamento entre os widgets
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.addNotePage);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
