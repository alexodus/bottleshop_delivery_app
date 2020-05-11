import 'package:bottleshopdeliveryapp/src/models/conversation.dart';
import 'package:bottleshopdeliveryapp/src/widgets/EmptyMessagesWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/MessageItemWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Conversation> conversations;
  @override
  void initState() {
    conversations = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
          Offstage(
            offstage: conversations.isEmpty,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 15),
              shrinkWrap: true,
              primary: false,
              itemCount: conversations.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 7);
              },
              itemBuilder: (context, index) {
                return MessageItemWidget(
                  message: conversations.elementAt(index),
                  onDismissed: (conversation) {
                    setState(() {
                      conversations.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          Offstage(
            offstage: conversations.isNotEmpty,
            child: EmptyMessagesWidget(),
          )
        ],
      ),
    );
  }
}
