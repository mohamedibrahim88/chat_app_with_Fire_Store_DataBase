import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName,this.userImage,this.isMe, {this.key});

  final String message;
  final bool isMe;
  final String userImage;
  final Key key;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 150,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.title.color),
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.title.color),
                ),
              ],
            ),
          ),
        ],
      ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImage,
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
