import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/_active_text_provider.dart';

class SurahNumber extends StatelessWidget {
  const SurahNumber({
    super.key,
    required this.ayahNumber,
    required this.activeIndex,
    required this.activeTextProvider,
    required this.surahName,
    this.index,
  });

  final ayahNumber;
  final activeIndex;
  final ActiveTextProvider activeTextProvider;
  final surahName;
  final index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '#$ayahNumber',
          style: GoogleFonts.inter(
              fontSize: 18,
              color: index == activeIndex &&
                      activeTextProvider.activeText == surahName
                  ? Colors.white
                  : Colors.black),
        )
      ],
    );
  }
}
