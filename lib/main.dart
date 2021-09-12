import 'package:covid_track/resources/consts.dart';
import 'package:covid_track/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: swatchify(Colors.blue, 700),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(brightness: Brightness.light),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: SplashScreen(),
    );
  }
}
