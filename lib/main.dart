import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/pages/landing_pages/_landing.dart';
import 'presentation/pages/main_page/_page_index.dart';
import 'presentation/providers/_active_text_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveTextProvider>(
          create: (context) => ActiveTextProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _result;

  @override
  void initState() {
    super.initState();
    _result = _init();
  }

  Future<bool> _init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if 'opened' flag exists
    bool opened = prefs.getBool('opened') ?? false;

    if (!opened) {
      // If 'opened' flag is false, set it to true
      await prefs.setBool('opened', true);
    }

    print(opened);
    return opened;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _result,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            final bool opened = snapshot.data ?? false;
            return opened ? const LandingPage() : const IndexPage();
          }
        },
      ),
    );
  }
}
