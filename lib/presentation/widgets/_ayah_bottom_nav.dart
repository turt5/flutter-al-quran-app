import 'package:al_quran/presentation/providers/_active_text_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AyahBottomNavigation extends StatelessWidget {
  const AyahBottomNavigation(
      {super.key,
      required this.activeIndex,
      required this.activeTextProvider,
      required this.surahName,
      required this.ayahEnglish,
      required this.index});

  final activeIndex;
  final ActiveTextProvider activeTextProvider;
  final surahName;
  final ayahEnglish;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: index == activeIndex && activeTextProvider.activeText == surahName
          ? Colors.white
          : CupertinoColors.activeGreen,
      child: Row(
        children: [
          Text(
            "Juzz/Para: ",
            style: GoogleFonts.poppins(
                fontSize: 12,
                color: index == activeIndex &&
                        activeTextProvider.activeText == surahName
                    ? Colors.grey.shade500
                    : Colors.grey.shade300,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 5),
          Text(
            "${ayahEnglish['juz']}",
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: index == activeIndex &&
                        activeTextProvider.activeText == surahName
                    ? Colors.black
                    : Colors.white),
          ),
        ],
      ),
    );
  }
}
