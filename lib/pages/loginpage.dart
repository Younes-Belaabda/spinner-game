import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wheel_app/pages/registerpage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final email = TextEditingController();
  final pwd = TextEditingController();

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('auth/login-bg.jpg'), fit: BoxFit.cover)),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              // color: Colors.amber,
              height: 40,
              child: TitleLoginWidget(),
            ),
            Container(
              height: 100,
              // color: Colors.green,
              child: FormControlLoginWidget(
                controller: email,
                title: 'البريد الإلكتروني',
              ),
            ),
            Container(
              height: 100,
              // color: Colors.red,
              child: FormControlLoginWidget(
                controller: pwd,
                title: 'كلمة المرور',
              ),
            ),
            Container(
                // color: Colors.blue,
                height: 100,
                child: FormSubmitWidget(
                  email: email,
                  pwd: pwd,
                )),
            Container(
              height: 30,
              // color: Colors.teal,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Divider(
                  thickness: 2.5,
                ),
              ),
            ),
            Container(
              height: 50,
              // color: Colors.blue,
              child: Center(
                child: Container(
                  width: 300,
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () =>
                        {Navigator.of(context).popAndPushNamed('register')},
                    child: Text(
                      'تسجيل',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                height: 60,
                // color: Color.fromARGB(255, 212, 58, 58),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () => {},
                          iconSize: 10,
                          icon: Image.asset('google-auth.png')),
                      IconButton(
                          onPressed: () => {},
                          iconSize: 10,
                          icon: Image.asset('facebook-auth.png')),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class FormSubmitWidget extends StatelessWidget {
  const FormSubmitWidget({
    super.key,
    required this.email,
    required this.pwd,
  });

  final TextEditingController email;
  final TextEditingController pwd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.only(left: 40, right: 40),
        color: Color.fromARGB(255, 255, 218, 7),
        child: TextButton(
            onPressed: () async {
              try {
                final credential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email.text, password: pwd.text);
                Navigator.of(context).pushReplacementNamed('homepage');
              } on FirebaseAuthException catch (e) {
                var msg = '';
                switch (e.code) {
                  case 'invalid-email':
                    msg = 'خطأ في البريد الإلكتروني';
                    break;
                  case 'user-not-found':
                    msg = 'المستخدم غير موجود';
                    break;
                  case 'wrong-password':
                    msg = 'كلمة المرور خاطئة';
                    break;
                  case 'invalid-credential':
                    msg = 'خطأ في المعلومات';
                    break;
                  default:
                    msg = 'خطأ في المعلومات';
                }
                print(e.code);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "خطأ في المعلومات",
                        ),
                        content: Text(msg),
                        //buttons?
                        actions: <Widget>[
                          TextButton(
                            child: Text("غلق"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              }
            },
            child: Text(
              'الدخول',
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}

class FormControlLoginWidget extends StatelessWidget {
  const FormControlLoginWidget({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: TextField(
              controller: controller,
              // obscureText: obscureText,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TitleLoginWidget extends StatelessWidget {
  const TitleLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Center(
        child: Text(
          'تسجيل الدخول',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
