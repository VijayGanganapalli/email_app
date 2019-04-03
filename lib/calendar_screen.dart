import 'package:email_app/app_drawer.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Center(
            child: Text('Calendar'),
          );
        }
      ),
    );
  }
}