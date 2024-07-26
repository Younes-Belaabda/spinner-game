import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wheel_app/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final email = TextEditingController();
  final pwd = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    pwd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('login');
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('auth/login-bg.jpg'), fit: BoxFit.cover)),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 40,
              child: TitleLoginWidget(title: 'تسجيل جديد'),
            ),
            Container(
              height: 100,
              child: FormControlLoginWidget(
                controller: email,
                title: 'البريد الإلكتروني',
              ),
            ),
            Container(
                height: 100,
                child: FormControlLoginWidget(
                  controller: pwd,
                  title: 'كلمة المرور',
                )),
            Container(
              height: 50,
              child: FormSubmitWidget(email: email, pwd: pwd),
            )
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
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text,
                  password: pwd.text,
                );

                Navigator.of(context).popAndPushNamed('homepage');
              } on FirebaseAuthException catch (e) {
                var msg = '';
                switch (e.code) {
                  case 'weak-password':
                    msg = 'كلمة المرور ضعيفة';
                    break;
                  case 'email-already-in-use':
                    msg = 'البريد مستخدم من قبل';
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
              'تسجيل',
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}

class TitleLoginWidget extends StatelessWidget {
  const TitleLoginWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
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
// class _RegisterpageState extends State<Registerpage> {
//   final email = TextEditingController();
//   final pwd   = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     email.dispose();
//     pwd.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).popAndPushNamed('login');
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           height: MediaQuery.of(context).size.height - 50,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   FadeInUp(
//                       duration: const Duration(milliseconds: 1000),
//                       child: const Text(
//                         "Sign up",
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                       )),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   FadeInUp(
//                       duration: const Duration(milliseconds: 1200),
//                       child: Text(
//                         "Create an account, It's free",
//                         style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//                       )),
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   FadeInUp(
//                       duration: const Duration(milliseconds: 1200),
//                       child: makeInput(controller: email, label: "Email")),
//                   FadeInUp(
//                       duration: const Duration(milliseconds: 1300),
//                       child: makeInput(
//                           controller: pwd,
//                           label: "Password",
//                           obscureText: true)),
//                   // FadeInUp(
//                   //     duration: const Duration(milliseconds: 1400),
//                   //     child: makeInput(
//                   //         controller: repwd,
//                   //         label: "Confirm Password", obscureText: true)),
//                 ],
//               ),
//               FadeInUp(
//                   duration: const Duration(milliseconds: 1500),
//                   child: Container(
//                     padding: const EdgeInsets.only(top: 3, left: 3),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         border: const Border(
//                           bottom: BorderSide(color: Colors.black),
//                           top: BorderSide(color: Colors.black),
//                           left: BorderSide(color: Colors.black),
//                           right: BorderSide(color: Colors.black),
//                         )),
//                     child: MaterialButton(
//                       minWidth: double.infinity,
//                       height: 60,
//                       onPressed: () async {
//                         
//                       },
//                       color: Colors.greenAccent,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50)),
//                       child: const Text(
//                         "Sign up",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 18),
//                       ),
//                     ),
//                   )),
//               FadeInUp(
//                   duration: const Duration(milliseconds: 1600),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       const Text("Already have an account?"),
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).popAndPushNamed('login');
//                         },
//                         child: const Text(
//                           " Login",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 18),
//                         ),
//                       ),
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget makeInput({controller, label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           label,
//           style: const TextStyle(
//               fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextField(
//           controller: controller,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade400)),
//             border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade400)),
//           ),
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//       ],
//     );
//   }
// }
