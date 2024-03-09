import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_page/_page_index.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  Future<void> setOpened() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('opened', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Text('Easy Al-Quran',
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(30),
                height: MediaQuery.of(context).size.height * 0.45,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(MediaQuery.of(context).size.height),
                  child: Image.network(
                      'https://cdn.dribbble.com/users/4636383/screenshots/15673435/media/6400639db89a51a8ed01d2610d4a7f30.png?resize=1000x750&vertical=center'),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    Text(
                      'Learn Quran with translation.',
                      style: GoogleFonts.inter(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Learn Quran with translation and recite once everyday',
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 150,
                child: Center(
                  child: SizedBox(
                      width: 350,
                      height: 45,
                      // margin: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CupertinoColors.activeBlue,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context,
                                          Animation animation,
                                          Animation secondaryAnimation) =>
                                      const IndexPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  }));
                        },
                        child: Text('Get Started',
                            style: GoogleFonts.poppins(fontSize: 13)),
                      )),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
