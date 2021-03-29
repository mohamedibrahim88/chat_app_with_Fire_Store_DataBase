import 'package:chat_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
        future: _initialization,
      builder: (context, appSnapshot)
    {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.purple,
          backgroundColor: Colors.pink,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home:appSnapshot.connectionState!=ConnectionState.done?SplashScreen(): StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if(userSnapshot.connectionState == ConnectionState.waiting){
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          },
        )
      );
    }
    );
  }
}
