import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/_active_text_provider.dart';
import '../../widgets/_surah_list.dart';
import '_surah.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Map<String, dynamic> jsonData = {};
  Map<String, dynamic> jsonData2 = {};
  Map<String, dynamic> jsonData3 = {};
  Map<String, dynamic> jsonData4 = {};

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadData();
    // init();
  }

  // void init() async {
  //   prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefs.setBool('opened', true);
  //   });
  // }

  Future<void> loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/quran.json');

      final String jsonString2 =
          await rootBundle.loadString('assets/quran-transliteration.json');

      final String jsonString3 =
          await rootBundle.loadString('assets/quran-audio.json');

      final String jsonString4 =
          await rootBundle.loadString('assets/quran-translate.json');

      setState(() {
        jsonData = json.decode(jsonString);
        jsonData2 = json.decode(jsonString2);
        jsonData3 = json.decode(jsonString3);
        jsonData4 = json.decode(jsonString4);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var activeText = Provider.of<ActiveTextProvider>(context).activeText;

    if (jsonData.isEmpty ||
        jsonData2.isEmpty ||
        jsonData3.isEmpty ||
        jsonData4.isEmpty ||
        jsonData['data'] == null ||
        jsonData2['data'] == null ||
        jsonData3['data'] == null ||
        jsonData4['data'] == null ||
        jsonData['data']['surahs'] == null) {
      // Handle the case when JSON data is not loaded properly
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Easy Al-Quran', style: GoogleFonts.inter()),
        toolbarHeight: 70,
        leading: const SizedBox(
          width: 0,
          height: 0,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: width > 600 ? 700 : width,
            alignment: Alignment.center,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Surahs',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(jsonData['data']['surahs'].length,
                        (index) {
                      final surah = jsonData['data']['surahs'][index];
                      final surahEnglishT = jsonData2['data']['surahs'][index];
                      final surahAudio = jsonData3['data']['surahs'][index];
                      final surahTranslate = jsonData4['data']['surahs'][index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SurahPage(
                                      surahAudio: surahAudio,
                                      surah: surah,
                                      index: index,
                                      surahEnglish: surahEnglishT,
                                      surahTranslate: surahTranslate)));
                        },
                        child: SurahList(activeText: activeText, surah: surah),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
