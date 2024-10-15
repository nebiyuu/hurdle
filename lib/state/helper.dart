import 'package:flutter/material.dart';

void showresult({
  required BuildContext context,
  required String title,
  required String body,
  required VoidCallback onplayagain,
  required VoidCallback oncancel,
}){
  showDialog(
    context: context,
    builder: (BuildContext context) =>AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(onPressed: oncancel, child: Text("Cancel")),
          TextButton(onPressed: onplayagain, child: Text("Play Again")),
        ],
      )
    
  );}