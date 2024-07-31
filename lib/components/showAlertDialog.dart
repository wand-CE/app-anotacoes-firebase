import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final String yesAnswer;
  final Function? alertAction;

  const ShowAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.yesAnswer = 'Salvar',
    this.alertAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      title: title,
      content: content,
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              alertAction!();
              Navigator.pop(context, 'OK');
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: 100,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.blueAccent),
              child: Text(
                yesAnswer,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
