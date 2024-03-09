import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/main_page/_surah.dart';

class AppbarSurahName extends StatelessWidget {
  const AppbarSurahName({
    super.key,
    required this.widget,
  });

  final SurahPage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${widget.surah['name']}",
            style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(width: 5),
        Text("(${widget.surah['englishName']})",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
