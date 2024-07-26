import 'package:flutter/material.dart';

class GainQuoti extends StatefulWidget {
  const GainQuoti({super.key});

  @override
  State<GainQuoti> createState() => _GainQuotiState();
}

class _GainQuotiState extends State<GainQuoti> {
  var height, width;

  List imgData = [
    "assets/case.jpg",
    "assets/case.jpg",
    "assets/case.jpg",
    "assets/case.jpg",
    "assets/case.jpg",
    "assets/case.jpg",
  ];
  List titles = [
    "1 UC",
    "2 UC",
    "3 UC",
    "4 UC",
    "5 UC",
    "6 UC",
  ];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(
            right: 0,
            left: 80,
          ),
          child: Text(
            'الجائزة اليومية',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/wood2.jpg'),
                    fit: BoxFit.cover,
                  )),
                  height: height,
                  width: width,
                  padding: const EdgeInsets.only(bottom: 20, top: 150),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 5,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                imgData[index],
                                width: 100,
                              ),
                              Text(
                                titles[index],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
