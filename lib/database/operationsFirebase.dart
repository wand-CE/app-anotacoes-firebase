import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../AppRoutes.dart';

class DatabaseOperationsFirebase {
  final db = FirebaseFirestore.instance;

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
    String id_user = '${FirebaseAuth.instance.currentUser!.uid}';

    await db
        .collection("anotacoes")
        .where("id_user", isEqualTo: id_user)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        Map<String, dynamic> dict_notes = doc.data();
        dict_notes['id'] = doc.id;
        listNotes.add(dict_notes);
      }
    }).catchError((e) {
      print('Got error: $e');
    });

    return listNotes;
  }

  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> removeNote(String id_note) async {
    db.collection("anotacoes").doc('$id_note').delete();
  }

  Future<bool> addAnotacao(String noteTitle, String noteText) async {
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

  Future<bool> editAnotacao(
      String id_note, String noteTitle, String noteText) async {
    db.collection("anotacoes").doc(id_note).update({
      "title": "$noteTitle",
      "text": "$noteText",
    });

    return true;
  }

  Future<Map<String, dynamic>?> returnDataNote(String id_note) async {
    try {
      DocumentSnapshot currentDoc = await FirebaseFirestore.instance
          .collection("anotacoes")
          .doc(id_note)
          .get();

      return currentDoc.exists
          ? currentDoc.data() as Map<String, dynamic>?
          : null;
    } catch (e) {
      print('Erro ao obter documento: $e');
      return null;
    }
  }
}
