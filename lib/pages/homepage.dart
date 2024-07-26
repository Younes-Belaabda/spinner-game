import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter/services.dart';
import 'package:wheel_app/profile.dart';
import 'package:wheel_app/gain_quoti.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wheel_app/withdraw.dart';
import 'package:wheel_app/invite.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

int getd(){
  return 5;
}

class _HomepageState extends State<Homepage> {
  StreamController<int> controller = StreamController<int>();
  int _spin_count = getd();
  int _uc_count = getd();
  int _uc = getd();

  List<FortuneItem> items = [
    const FortuneItem(child: Text('1')),
    const FortuneItem(child: Text('40')),
    const FortuneItem(child: Text('0')),
    const FortuneItem(child: Text('10')),
    const FortuneItem(child: Text('8')),
    const FortuneItem(child: Text('X1')),
    const FortuneItem(child: Text('6')),
    const FortuneItem(child: Text('5')),
    const FortuneItem(child: Text('3')),
    const FortuneItem(child: Text('2')),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;





    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Container(
          color: Colors.white,
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: Text('${_spin_count}'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/pubg.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            // Padding(padding: EdgeInsets.all(30) , child:
            //   Text('Hi'),),

            const SizedBox(
              height: 150,
            ),
            Container(
              color: Colors.white,
              height: 80,
              width: 240,
              alignment: Alignment.center,
              child: Text('${_uc_count}' ' UC'),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(
                    child: FortuneWheel(
                      duration: const Duration(seconds: 3),
                      selected: controller.stream,
                      // curve: Curves.bounceIn,
                      animateFirst: false,
                      items: items,
                      onAnimationStart: () {
                        print("On Start");
                      },
                      onAnimationEnd: () {
                        setState(() {
                          _uc_count += _uc;
                        });
                        setState(() {
                        _spin_count--;
                        });
                      },
                      onFling: () {},
                      onFocusItemChanged: (e) {
                        print(e);
                      },
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            MaterialButton(
              minWidth: 200,
              height: 60,
              onPressed: () {
                if (false) {
                  controller.add([1][new Random().nextInt([1].length)]);
                } else {
                  _uc = Random().nextInt(items.length);
                  controller.add(_uc);
                  //save uc
                  //save spin
                }
              },
              color: const Color.fromARGB(166, 255, 235, 59),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: const Text(
                "تدوير",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                'AHMED',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                'test@test.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image(image: AssetImage('assets/face.jpg')),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/pubg.jpg'), fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('الحساب'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('الجائزة اليومية'),
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: const Center(
                      child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  )),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const GainQuoti()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('سحب'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Withdraw()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('مشاركة'),
              onTap: () async {
                await Share.share('com.example.wheel_app');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('الدعم'),
              onTap: (() {
                sendWhatsApp();
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('الدعوة'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Invite()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('تسجيل الخروج'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).popAndPushNamed('login');
                  // Navigator.of(context).pushReplacementNamed('login');
                }),
          ],
        ),
      ),
    );
  }


  void sendWhatsApp() {
    String url = "https://wa.me/212631872384";
    launchUrl(Uri.parse(url));
  }
}
