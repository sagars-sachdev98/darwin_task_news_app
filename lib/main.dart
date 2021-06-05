import 'package:darwin_task/home.dart';
import 'package:darwin_task/search_everything.dart';
import 'package:darwin_task/top_headlines.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.green),
            // hintStyle: TextStyle(color: Colors.green),
          )),
      onGenerateRoute: routing,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //  home: ClaimStatus(),
      // home: ContactsPage(),
    );
  }

  Route routing(settings) {
    switch (settings.name) {
      case '/topHeadlines':
        return PageTransition(
            child: TopHeadlines(),
            type: PageTransitionType.rightToLeftWithFade);
        break;
      case '/search':
        return PageTransition(
            child: SearchEverything(), type: PageTransitionType.bottomToTop);
        break;
      default:
        return null;
    }
  }
}
