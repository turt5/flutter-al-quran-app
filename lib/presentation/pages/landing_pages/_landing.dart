import 'package:flutter/material.dart';

import '_page1.dart';
import '_page2.dart';
import '_page3.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  final List<Widget> pages = const [
    Page1(),
    Page2(),
    Page3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.red,
            width: 500,
            child: PageView(
              children: pages,
            )),
      ),
    ));
  }
}
