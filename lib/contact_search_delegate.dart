import 'package:email_app/contact_list_builder.dart';
import 'package:email_app/model/contact.dart';
import 'package:flutter/material.dart';

class ContactSearchDelegate extends SearchDelegate {
  final manager;

  ContactSearchDelegate({this.manager});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Center(
        child: Text('Type at least 3 letters to search'),
      );
    }

    return ContactListBuilder(
      stream: manager.filteredContactCollection(query: query),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
