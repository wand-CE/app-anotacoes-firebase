import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../AppRoutes.dart';

class DatabaseOperationsFirebase {
  final db = FirebaseFirestore.instance;

  Future<void> editUserNameFirebase(String userId, String novoNome) async {
    var collection = FirebaseFirestore.instance.collection('users');

    collection.doc(userId).update({'nome': novoNome});
  }

  Future<void> deletePersonFirebase(String userId) async {
    db.collection("users").doc(userId).delete();
  }

  Future<void> createNewUserAcoount(
      context, String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential);
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInEmailPass(
      context, String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code}')));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code}')));
      }
    }
  }

  Future<List<dynamic>> getNotes() async {
    List<Object> listNotes = [];

    await db.collection("anotacoes").get().then((event) {
      for (var doc in event.docs) {
        Map<String, dynamic> dict_notes = doc.data();
        dict_notes['id'] = doc.id;
        listNotes.add(dict_notes);
      }
    });
    print(listNotes);

    return listNotes;
  }

  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> removeAnotacao(context, String id_anotacao) async {
    db
        .collection("anotacoes")
        .doc('$id_anotacao')
        .delete(); // trocar id para string
  }

  Future<bool> addAnotacao(context, String noteTitle, String noteText) async {
    String id_user = '${FirebaseAuth.instance.currentUser!.uid}';

    final note = <String, dynamic>{
      "id_user": "$id_user",
      "title": "$noteTitle",
      "text": "$noteText",
    };

    await db.collection("anotacoes").add(note).then((DocumentReference doc) {
      return true;
    });
    return false;
  }

  Future<Object> returnDataNote(context, id_anotacao) async {
    List<dynamic> dados = [];

    print(db.collection("anotacoes").doc('$id_anotacao').get());

    return dados;
  }
}
