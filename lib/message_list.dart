import 'package:email_app/message.dart';
import 'package:email_app/message_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessageList extends StatefulWidget {
  final String title;
  final String status;

  MessageList({Key key, this.title, this.status = 'important'})
      : super(key: key);

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
    future = Message.browse(status:widget.status);
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
              separatorBuilder: (BuildContext context, int index) => Divider(),
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
    );
  }
}
