import 'package:email_app/app_drawer.dart';
import 'package:email_app/contact_list_builder.dart';
import 'package:email_app/contacts_manager.dart';
import 'package:email_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:email_app/contact_search_delegate.dart';

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
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(manager: manager),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ContactListBuilder(
        stream: manager.contactListNow,
        builder: (context, contacts) {
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
            separatorBuilder: (BuildContext context, int index) => Divider(),
          );
        },
      ),
    );
  }
}
