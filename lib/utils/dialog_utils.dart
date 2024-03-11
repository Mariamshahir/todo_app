import 'package:flutter/material.dart';
import 'package:todo/utils/messages.dart';

abstract class DialogUtils {
  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Row(
              children: [
                Text(
                  "Loading...",
                  style: TextStyle(fontSize: 20,color: Colors.black),
                ),
                Spacer(),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Color(0xFF3AA7DB),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showError(BuildContext context, [String? message]) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Error"),
              content: Text(message??Messages.defaultErrorMessage),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ))
              ],
            ));
  }
}
