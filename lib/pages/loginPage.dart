import 'package:flutter/material.dart';
import '../AppRoutes.dart';

import '../database/operationsFirebase.dart';
import 'forgotPassPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DatabaseOperationsFirebase firebase = DatabaseOperationsFirebase();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faça seu Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 200, 30, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text('E-mail'),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo email vazio';
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Senha'),
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo senha vazio';
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    firebase.signInEmailPass(context, _emailController.text,
                        _passwordController.text);
                  }
                },
                child: Text('Entrar'),
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
              ),
              TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, AppRoutes.signUpPage),
                  child: Text('Criar uma nova conta')),
              TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, AppRoutes.forgotPassPage),
                  child: Text('Esqueci minha senha'))
            ],
          ),
        ),
      ),
    );
  }
}
