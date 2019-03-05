import 'package:email_app/message_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MessageList(title: 'Email App'),
    );
  }
}