import 'package:al_quran/data/_search_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_page/_surah.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _enteredText = '';
  List<Map<String, dynamic>> result = [];

  bool isFailed() {
    return result.isNotEmpty && result[0]['response'] == 'failed';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 80,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            onChanged: (text) async {
              if (text.trim().isNotEmpty) {
                setState(() => _enteredText = text.trim());
              }
              try {
                List<Map<String, dynamic>> searchResult =
                    await Search.getSearchResult(_enteredText);
                setState(() => result = searchResult);
                if (result.isNotEmpty && result[0]['response'] == 'success') {
                  print(result[0]['englishName']);
                }
              } catch (e) {
                print("Error: $e");
                // Handle error here
              }
            },
            style: TextStyle(fontFamily: 'Inter'),
            decoration: InputDecoration(
              hintText: 'Search Surah By Name',
              hintStyle: TextStyle(fontFamily: 'Inter'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: isFailed() || result.isEmpty
            ? Center(
                child: Text(
                  'No Surah found',
                  style: GoogleFonts.inter(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            : buildResultList(),
      ),
    );
  }

  Widget buildResultList() {
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: index == 0
                  ? Text(
                      'Surahs Found: ${result.length}',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ),
            buildSurahCard(index),
          ],
        );
      },
    );
  }

  Widget buildSurahCard(int index) {
    return GestureDetector(
      onTap: () {
        // Navigate to Surah page
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SurahPage(
            index: index,
          );
        }));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
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
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              result[index]['number'],
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              result[index]['arabicName'],
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              result[index]['englishName'],
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Ayahs: ${result[index]['numberOfAyahs']}",
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Relevation: ${result[index]['revelationType']}",
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
