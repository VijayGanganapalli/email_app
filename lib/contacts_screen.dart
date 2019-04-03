import 'package:email_app/app_drawer.dart';
import 'package:email_app/contacts_manager.dart';
import 'package:email_app/model/contact.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  final ContactManager manager = ContactManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: <Widget>[
          Chip(
            label: StreamBuilder<int>(
              stream: manager.contactCounter,
              builder: (context, snapshot) {
                return Text(
                  (snapshot.data ?? 0).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              },
            ),
            backgroundColor: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<List<Contact>>(
        stream: manager.contactListNow,
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

              return ListView.separated(
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  Contact _contact = contacts[index];

                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text(_contact.name),
                    subtitle: Text(_contact.phone),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              );
          }
        },
      ),
    );
  }
}
