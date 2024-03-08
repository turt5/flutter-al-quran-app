import 'package:al_quran/data/_quran_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '_surah.dart'; // Assuming this contains SurahPage Widget
import '../../widgets/_surah_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late SharedPreferences prefs;
  late String activeText;
  Map<String, dynamic> jsonData = {};

  @override
  void initState() {
    super.initState();
    init();
    loadData();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      activeText = prefs.getString('activeText') ?? '';
    });
  }

  Future<void> loadData() async {
    try {
      final data = await SurahListService.fetchQuranData();
      setState(() {
        jsonData = data;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
          child: buildSurahsListView(),
        ),
      ),
    );
  }

  Widget buildSurahsListView() {
    double width = MediaQuery.of(context).size.width;
    return Container(
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
              children: List.generate(
                jsonData['data']['surahs'].length,
                (index) {
                  final surah = jsonData['data']['surahs'][index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahPage(
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: SurahListItem(activeText: activeText, surah: surah),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SurahListItem extends StatelessWidget {
  final String activeText;
  final dynamic surah;

  const SurahListItem({
    required this.activeText,
    required this.surah,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SurahList(activeText: activeText, surah: surah);
  }
}
