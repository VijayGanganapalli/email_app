import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String subject;
  final String body;

  Message(this.subject, this.body);
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static Future<List<Message>> browse({status: 'important'}) async {
    String url = status == 'important'
        ? 'http://www.mocky.io/v2/5c9add223500004c00d0c78d'
        : 'http://www.mocky.io/v2/5c803a5933000072628485c4';
    
    http.Response response = await http.get(url);

    await Future.delayed(Duration(seconds: 1));
    String content = response.body;

    List collection = json.decode(content);
    List<Message> _messages =
        collection.map((json) => Message.fromJson(json)).toList();

    return _messages;
  }
}
