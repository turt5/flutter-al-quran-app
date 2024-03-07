import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahList extends StatelessWidget {
  const SurahList({
    super.key,
    required this.activeText,
    required this.surah,
  });

  final String activeText;
  final Map<String, dynamic> surah;

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: const Duration(milliseconds: 600),
      // curve: Curves.linearToEaseOut,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: activeText == surah['englishName']
              ? CupertinoColors.activeBlue
              : Colors.white,
          boxShadow: [
            const BoxShadow(
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
            )
          ]),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text("${surah['number']}.",
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: activeText == surah['englishName']
                      ? Colors.white
                      : Colors
                          .black)), // Access the 'number' property of the current surah

          const SizedBox(width: 10),
          Text(
            // textDirection: TextDirection.rtl,
            "${surah['name']}",
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: activeText == surah['englishName']
                    ? Colors.white
                    : Colors.black),
          ),
          const SizedBox(width: 10),
          Text(
            '(${surah['englishName']})',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: activeText == surah['englishName']
                    ? Colors.grey.shade300
                    : Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
