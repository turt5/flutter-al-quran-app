import 'package:al_quran/presentation/providers/_active_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahEnglishMeaning extends StatelessWidget {
  const SurahEnglishMeaning({
    super.key,
    required this.ayahTranslate,
    required this.size,
    required this.activeIndex,
    required this.activeTextProvider,
    required this.surahName,
    this.index,
  });

  final ayahTranslate;
  final double size;
  final activeIndex;
  final ActiveTextProvider activeTextProvider;
  final surahName;
  final index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Text(
            textAlign: TextAlign.start,
            "${ayahTranslate['text']}",
            style: GoogleFonts.inter(
                // fontWeight: FontWeight.bold,
                fontSize: size - 2,
                color: index == activeIndex &&
                        activeTextProvider.activeText == surahName
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ],
    );
  }
}
