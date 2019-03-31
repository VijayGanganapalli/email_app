import 'package:email_app/app_drawer.dart';
import 'package:email_app/message_list.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {},
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text('Important')),
              Tab(child: Text('Other')),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: <Widget>[
            MessageList(status: 'important'),
            MessageList(status: 'other'),
          ],
        ),
      ),
    );
  }
}
