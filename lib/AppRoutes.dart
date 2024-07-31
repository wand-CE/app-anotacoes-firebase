import 'package:aplicativo_anotacoes_firebase/pages/editNotePage.dart';
import 'package:aplicativo_anotacoes_firebase/pages/forgotPassPage.dart';
import 'package:aplicativo_anotacoes_firebase/pages/homePage.dart';
import 'package:aplicativo_anotacoes_firebase/pages/loginPage.dart';
import 'package:aplicativo_anotacoes_firebase/pages/addNotePage.dart';
import 'package:aplicativo_anotacoes_firebase/pages/signUpPage.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const homePage = '/homePage';
  static const signUpPage = '/signUpPage';
  static const loginPage = '/loginPage';
  static const forgotPassPage = '/forgotPassPage';
  static const addNotePage = '/addNotePage';

  static Map<String, WidgetBuilder> define() {
    return {
      homePage: (BuildContext context) => HomePage(),
      signUpPage: (BuildContext context) => SignUpPage(),
      loginPage: (BuildContext context) => LoginPage(),
      forgotPassPage: (BuildContext context) => ForgotPassPage(),
      addNotePage: (BuildContext context) => AddNotePage(),
    };
  }
}
