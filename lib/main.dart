import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Pages
import 'package:wheel_app/pages/homepage.dart';
import 'package:wheel_app/pages/loginpage.dart';
import 'package:wheel_app/pages/registerpage.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if user is authenticated
    // depends of authentication choose the right route
    User? user = FirebaseAuth.instance.currentUser;
    String initialRoute = 'login';
    if (user != null) {
      initialRoute = 'homepage';
    }

    // User State Change
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print(user.uid);
        FirebaseFirestore db = FirebaseFirestore.instance;
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            print('Document exists on the database');
          }else{
            db.collection("users")
                .doc(user.uid)
                .set({
                  'name': null,
                  'spin_count': 3,
                  'uc_count': 0
                })
                .onError((e, _) => print("Error writing document: $e"));
          }
        });
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        "homepage": (context) => const Homepage(),
        "login": (context) => const Loginpage(),
        "register": (context) => const Registerpage(),
      },
    );
  }
}
