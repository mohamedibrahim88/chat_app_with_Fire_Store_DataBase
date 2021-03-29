import 'package:chat_app/widgets/messages/messages.dart';
import 'package:chat_app/widgets/messages/new_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  didChangeDependencies()async{
    super.didChangeDependencies();
    // FirebaseMessaging firebaseMessaging=FirebaseMessaging();
    // Get any messages which caused the application to open from
   try { // a terminated state.
     RemoteMessage initialMessage =
     await FirebaseMessaging.instance.getInitialMessage();

     // If the message also contains a data property with a "type" of "chat",
     // navigate to a chat screen
     //if (initialMessage?.data['type'] == 'chat') {
       print(initialMessage);
     //}
     // Also handle any interaction when the app is in the background via a
     // Stream listener
     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // if (message.data['type'] == 'chat') {
         print(message);
    //   }
     }
     );
     FirebaseMessaging.instance.subscribeToTopic('chat');
   }catch(error){
     print(error);
   }
  }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('flutter chat'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme
                    .of(context)
                    .primaryIconTheme
                    .color,
              ),
              items: [
                DropdownMenuItem(child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIdentfier) {
                if (itemIdentfier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Messages()
              ),
              NewMessage()
            ],
          ),
        ),
      );
    }
  }

