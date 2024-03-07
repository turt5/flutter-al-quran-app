import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/pages/landing_pages/_landing.dart';
import 'presentation/pages/main_page/_page_index.dart';
import 'presentation/providers/_active_text_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('font_size', 18.0);
  prefs.setInt('active_index', -1);
  prefs.setInt('active_surah', -1);
  prefs.setString('active_text', '');
  prefs.setBool('opened', false);
  // Set 'opened' to true after initialization
  await prefs.setBool('opened', true);

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final prefs = snapshot.data!;
            return prefs.getBool('opened') == false
                ? const LandingPage()
                : const IndexPage();
          } else {
            // Return a loading indicator while waiting for SharedPreferences to initialize.
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
