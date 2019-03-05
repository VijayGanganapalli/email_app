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
      home: HomeScreen(title: 'Email App'),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;
  final messages = const [
    {
      'subject': 'My first message',
      'body':
          'This message is very very long so you can easily understand to read and also see. You should reply after see it.',
    },
    {
      'subject': 'You won lottery',
      'body':
          'This message is very very long so you can easily understand to read and also see. You should reply after see it.',
    },
    {
      'subject': 'You should read this message',
      'body':
          'This message is very very long so you can easily understand to read and also see. You should reply after see it.',
    },
    {
      'subject': 'An email from Google',
      'body':
          'This message is very very long so you can easily understand to read and also see. You should reply after see it.',
    },
    {
      'subject': 'You won another lottery',
      'body':
          'This message is very very long so you can easily understand.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          var message = messages[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('VK'),
            ),
            title: Text(message['subject']),
            subtitle: Text(
              message['body'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
