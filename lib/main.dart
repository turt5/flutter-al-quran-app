import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/pages/landing_pages/_landing.dart';
import 'presentation/pages/main_page/_page_index.dart';
import 'presentation/providers/_active_text_provider.dart';
import 'services/_check_session.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveTextProvider>(
          create: (context) => ActiveTextProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: checkFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final bool isFirstLaunch = snapshot.data ?? true;
          return isFirstLaunch ? LandingPage() : IndexPage();
        },
      ),
    );
  }
}
