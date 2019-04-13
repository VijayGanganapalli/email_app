import 'package:email_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ContactListBuilder extends StatelessWidget {
  final Stream<List<Contact>> stream;
  final Function builder;

  const ContactListBuilder({this.stream, this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Contact>>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text('There was an error: ${snapshot.error}');
            List<Contact> contacts = snapshot.data;

            return builder(context, contacts);
        }
      },
    );
  }
}
