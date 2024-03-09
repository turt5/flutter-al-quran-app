import 'package:al_quran/data/_quran_service.dart';
import 'package:al_quran/presentation/widgets/_sajda_alert.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../providers/_active_text_provider.dart';
import '../../widgets/_appbar_surah_name.dart';
import '../../widgets/_ayah_bottom_nav.dart';
import '../../widgets/_decrease_font.dart';
import '../../widgets/_increase_font.dart';
import '../../widgets/_surah_arabic.dart';
import '../../widgets/_surah_eng.dart';
import '../../widgets/_surah_eng_meaning.dart';
import '../../widgets/_surah_number.dart';

class SurahPage extends StatefulWidget {
  SurahPage({
    super.key,
    // required this.surah,
    required this.index,
    // required this.surahEnglish,
    // required this.surahAudio,
    // required this.surahTranslate
  });
  Map<String, dynamic> surah = {};
  final index;
  Map<String, dynamic> surahEnglish = {};
  Map<String, dynamic> surahAudio = {};
  Map<String, dynamic> surahTranslate = {};

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late SharedPreferences prefs;
  double size = 18.0;
  late AssetsAudioPlayer _assetsAudioPlayer;

  @override
  void initState() {
    super.initState();
    loadData(widget.index);
    _assetsAudioPlayer = AssetsAudioPlayer();
    // Listen to player events
    _assetsAudioPlayer.playlistFinished.listen((finished) {
      setState(() {
        playing = false;
      });
    });
    _assetsAudioPlayer.current.listen((playingAudio) {
      setState(() {
        playing = _assetsAudioPlayer.isPlaying.value;
      });
    });

    initPrefs(); // Call initPrefs() here
  }

  Future<void> loadData(int index) async {
    try {
      final data = await SurahArabicX.fetchQuranData(index);
      final dataTranslate =
          await SurahEnglishTranslateService.fetchQuranData(index);
      final dataAudio = await SurahAudioService.fetchQuranData(index);
      final dataTranliteration =
          await SurahEnglishTransliterationService.fetchQuranData(index);

      setState(() {
        widget.surah = data;
        widget.surahTranslate = dataTranslate;
        widget.surahAudio = dataAudio;
        widget.surahEnglish = dataTranliteration;
      });

      print(widget.surah = data['data']['surahs'][widget.index].length);
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      size = prefs.getDouble('font_size') ?? 18.0;
      activeIndex = prefs.getInt('active_index') ?? -1;
      activeSurah = prefs.getInt('active_surah') ?? -1;
    });
    print(prefs.getString('active_Surah')); // You can access prefs here
  }

  var color = Colors.white;
  var activeIndex;
  var activeSurah;
  var playing = false;
  var clicked = false;
  var clickedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.surah.isEmpty ||
        widget.surahEnglish.isEmpty ||
        widget.surahAudio.isEmpty ||
        widget.surahTranslate.isEmpty) {
      // Handle the case when JSON data is not loaded properly

      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final activeTextProvider = Provider.of<ActiveTextProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (size < 42) {
                          setState(() {
                            size += 2;
                            prefs.setDouble('font_size', size);
                          });
                        }
                      },
                      icon: const IncreaseFontSize()),
                  IconButton(
                      onPressed: () {
                        if (size > 10) {
                          setState(() {
                            size -= 2;
                            prefs.setDouble('font_size', size);
                          });
                        }
                      },
                      icon: const DecreaseFontSize()),
                ],
              ),
            )
          ],
          toolbarHeight: 70,
          centerTitle: true,
          title: AppbarSurahName(widget: widget)),
      body: SafeArea(
          child: Center(
        child: Container(
          width: width > 600 ? 800 : width,
          alignment: Alignment.center,
          child: ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.surah['ayahs'].length,
                  itemBuilder: (context, index) {
                    final ayah =
                        widget.surah['ayahs'][index]; // Access the current ayah
                    final ayahNumber = ayah[
                        'numberInSurah']; // Access the 'number' property of the current ayah
                    final surahName = widget.surah['englishName'];
                    final ayahEnglish = widget.surahEnglish['ayahs'][index];
                    final ayahVoice = widget.surahAudio['ayahs'][index];
                    final ayahTranslate = widget.surahTranslate['ayahs'][index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!clicked) {
                            // If not clicked, set the color, activeIndex, activeTextProvider, and prefs
                            color = CupertinoColors.activeBlue;
                            activeIndex = index;
                            activeTextProvider
                                .setActiveText(widget.surah['englishName']);
                            prefs.setInt('active_index', index);
                            prefs.setInt(
                                'active_surah', widget.surah['number']);
                            clicked = true;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(5, 5),
                            ),
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(-5, -5),
                            )
                          ],
                          color: (index == activeIndex &&
                                  activeTextProvider.activeText == surahName)
                              ? CupertinoColors.activeBlue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Column(
                          children: [
                            SurahNumber(
                                ayahNumber: ayahNumber,
                                activeIndex: activeIndex,
                                activeTextProvider: activeTextProvider,
                                surahName: surahName),
                            const SizedBox(height: 30),
                            SurahArabic(
                                ayah: ayah,
                                width: width,
                                size: size,
                                activeIndex: activeIndex,
                                activeTextProvider: activeTextProvider,
                                surahName: surahName),
                            const SizedBox(height: 15),
                            Container(
                              height: 2,
                              width: double.infinity,
                              // margin: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 15),
                            SurahEnglish(
                                ayahEnglish: ayahEnglish,
                                size: size,
                                activeIndex: activeIndex,
                                activeTextProvider: activeTextProvider,
                                surahName: surahName),
                            const SizedBox(height: 15),
                            Container(
                              height: 2,
                              width: double.infinity,
                              // margin: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 15),
                            SurahEnglishMeaning(
                                ayahTranslate: ayahTranslate,
                                size: size,
                                activeIndex: activeIndex,
                                activeTextProvider: activeTextProvider,
                                surahName: surahName),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AyahBottomNavigation(
                                    activeIndex: activeIndex,
                                    activeTextProvider: activeTextProvider,
                                    surahName: surahName,
                                    index: index,
                                    ayahEnglish: ayahEnglish),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      clickedIndex = index;
                                      if (!playing) {
                                        _assetsAudioPlayer.open(
                                            Audio.network(ayahVoice['audio']));
                                        _assetsAudioPlayer
                                            .play(); // Start playing immediately
                                        playing = true;
                                      } else {
                                        _assetsAudioPlayer
                                            .stop(); // Stop if already playing
                                        playing = false;
                                        clickedIndex = -1;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    playing && index == clickedIndex
                                        ? Icons.pause_circle
                                        : Icons.play_circle,
                                    size: 30,
                                  ),
                                ),
                                ayah['sajda'] != false
                                    ? SajdaAlert(
                                        activeIndex: activeIndex,
                                        activeTextProvider: activeTextProvider,
                                        surahName: surahName,
                                        ayah: ayah)
                                    : const SizedBox(
                                        width: 0,
                                        height: 0,
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
