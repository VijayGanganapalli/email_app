import 'package:email_app/message.dart';
import 'package:email_app/compose_button.dart';
import 'package:email_app/message_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessageList extends StatefulWidget {
  MessageList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> future;
  List<Message> messages;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    future = Message.browse();
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                future = Message.browse();
              });
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars2.githubusercontent.com/u/28445596?s=460&v=4'),
              ),
              accountName: Text('Vijay Ganganapalli'),
              accountEmail: Text('vijayganganapalli@gmail.com'),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Adding new account...'),
                          );
                        });
                  },
                  child: CircleAvatar(
                    child: Text('+'),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.inbox),
              title: Text('Inbox'),
              trailing: Chip(
                label: Text(
                  '11',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),
              title: Text('Draft'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.archive),
              title: Text('Archive'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paperPlane),
              title: Text('Sent'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.trash),
              title: Text('Trash'),
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.cog),
                  title: Text('Settings'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              var messages = snapshot.data;
              return ListView.separated(
                itemCount: messages.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  Message message = messages[index];

                  return Slidable(
                    key: ObjectKey(message),
                    delegate: SlidableDrawerDelegate(),
                    actionExtentRatio: 0.25,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Archive',
                        color: Colors.blue,
                        icon: Icons.archive,
                        onTap: () {},
                      ),
                      IconSlideAction(
                        caption: 'Share',
                        color: Colors.indigo,
                        icon: Icons.share,
                        onTap: () {},
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () {},
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                           messages.removeAt(index); 
                          });
                        },
                      ),
                    ],
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('VK'),
                      ),
                      title: Text(message.subject),
                      subtitle: Text(
                        message.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MessageDetail(message.subject, message.body),
                          ),
                        );
                      },
                      isThreeLine: true,
                    ),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: ComposeButton(messages),
    );
  }
}
