import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wheel_app/Signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final email = TextEditingController();
  final pwd   = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: Text(
                              "تسجيل الدخول لحسابك",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: makeInput(controller: email , label: "البريد الإلكتروني")),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: makeInput(
                                  controller: pwd,
                                  label: "كلمة المرور", obscureText: true)),
                        ],
                      ),
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: const EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: const Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              ),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                try {
                                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: email.text,
                                      password: pwd.text
                                  );
                                  Navigator.of(context).pushReplacementNamed('homepage');
                                } on FirebaseAuthException catch (e) {
                                  var msg = '';
                                  switch(e.code){
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
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("خطأ في المعلومات",),
                                          content: Text(msg),
                                          //buttons?
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("غلق"),
                                              onPressed: () { Navigator.of(context).pop(); },
                                            )
                                          ],
                                        );
                                      });
                                }
                              },
                              color: Colors.greenAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text(
                                "الدخول",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ),
                        )),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("ليس لديك حساب ؟"),
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const SignupPage()));
                              },
                              child: const Text(
                                "تسجيل",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('bg-login.png'),
                            fit: BoxFit.fitHeight)),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({controller , label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}