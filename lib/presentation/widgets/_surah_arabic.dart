import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/_active_text_provider.dart';

class SurahArabic extends StatelessWidget {
  const SurahArabic({
    super.key,
    required this.ayah,
    required this.width,
    required this.size,
    required this.activeIndex,
    required this.activeTextProvider,
    required this.surahName,
    this.index,
  });

  final ayah;
  final double width;
  final double size;
  final activeIndex;
  final ActiveTextProvider activeTextProvider;
  final surahName;
  final index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          flex: 3,
          child: Text(
            "${ayah['text']}",
            textDirection: TextDirection.rtl,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: width > 600 ? size + 6 : size,
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

