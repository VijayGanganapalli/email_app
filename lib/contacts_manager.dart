import 'dart:async';

import 'package:email_app/model/contact.dart';
import 'package:email_app/service/contact_service.dart';

class ContactManager {
  Stream<List<Contact>> get contactListNow =>
      Stream.fromFuture(ContactService.browse());

      Stream<List<Contact>> filteredContactCollection({query}) =>
      Stream.fromFuture(ContactService.browse(query: query));

  final StreamController<int> _contactCounter = StreamController<int>();
  Stream<int> get contactCounter => _contactCounter.stream;

  ContactManager() {
    contactListNow.listen((list) => _contactCounter.add(list.length));
  }
}
