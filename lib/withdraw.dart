import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 110),
          child: Text(
            'سحب',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/wood2.jpg'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'انتبه \nلا يتم الموافقه علي طلب السحب الا بعد تحقيق المطلوب\n دعوه 5 اشخاص الي التطبيق\n تقيم التطبيق بي 5 نجوم \n يجب ان تظهر لديك اعلانات التطبيق بدون اي مشاكل',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                              child: const Text('500'),
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            const Image(
                              image: AssetImage('assets/case.jpg'),
                              width: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          color: Colors.white),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                              child: const Text('1000'),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            const Image(
                              image: AssetImage('assets/case.jpg'),
                              width: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          color: Colors.white),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                              child: const Text('1500'),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            const Image(
                              image: AssetImage('assets/case.jpg'),
                              width: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
