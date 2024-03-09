import 'package:al_quran/presentation/providers/_active_text_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SajdaAlert extends StatelessWidget {
  const SajdaAlert({
    super.key,
    required this.activeIndex,
    required this.activeTextProvider,
    required this.surahName,
    required this.ayah,
    this.index,
  });

  final activeIndex;
  final ActiveTextProvider activeTextProvider;
  final surahName;
  final ayah;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: index == activeIndex && activeTextProvider.activeText == surahName
          ? Colors.white
          : CupertinoColors.activeOrange,
      child: Text(
        'Sajda : ${ayah['sajda']['recommended'] == true ? '(Recommended)' : '(Obligatory)'}',
        style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: index == activeIndex &&
                    activeTextProvider.activeText == surahName
                ? Colors.black
                : Colors.white,
            fontSize: 12),
      ),
    );
  }
}
