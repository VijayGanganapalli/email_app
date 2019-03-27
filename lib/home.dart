import 'package:email_app/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:email_app/message_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
        drawer: HomeDrawer(),
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
