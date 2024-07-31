import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Senha'),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(30, 200, 30, 0),
          child: Column(
            children: [
              Text('Informe seu e-mail para recuperar a senha:'),
              SizedBox(height: 25),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: Text('E-mail'),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {},
                child: Text('Recuperar'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  minimumSize: Size.fromHeight(50),
                ),
              ),
            ],
          )),
    );
  }
}
