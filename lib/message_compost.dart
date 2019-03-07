import 'package:flutter/material.dart';

class MessageCompost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose new message'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Compose new messages',
              style: Theme.of(context).textTheme.title,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Love'),
                  onPressed: () {
                    Navigator.pop(context, "Love");
                  },
                ),
                RaisedButton(
                  child: Text('Hate'),
                  onPressed: () {
                     Navigator.pop(context, "Hate");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
