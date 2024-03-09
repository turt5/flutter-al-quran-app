import 'package:al_quran/data/_quran_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../search_page/_search.dart';
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
          const SizedBox(height: 20),
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   child: Text(
          //     'Search',
          //     style: GoogleFonts.inter(
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: width > 600 ? 700 : width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(5, 5),
                    ),
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(-5, -5),
                    ),
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: Colors.grey.shade500, size: 18),
                      const SizedBox(width: 10),
                      Text("Search a surah",
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade500,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jsonData['data']['surahs'].length,
              itemBuilder: (context, index) {
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
