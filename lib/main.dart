import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'data/wallpapers.dart';

// void main() function is the entry point of your app in flutter
void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(Portraits());
}

class Portraits extends StatelessWidget {
  // variable declaration is done before the build method
  static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

  // MaterialApp is a class which creates a instances of the widgetsApp.
  @override
  Widget build(BuildContext context) => MaterialApp(
        // title is declared which is shown on minimizing your app
        title: 'Portraits',
        // debugShowCheckedModeBanner is by default true, which shows the debug banner on your app
        debugShowCheckedModeBanner: false,
        // navigatorObservers creates observers for you in your app to observe a app behaviour
        navigatorObservers: <NavigatorObserver>[observer],
        // home param declares the root/main activity of your app.
        home: Wallpapers(),
        // theme declares the default visual properties, like colors fonts and shapes, for this app's material widgets.
        theme: ThemeData(
          primaryColor: Color.fromRGBO(9, 9, 26, 1.0),
          cardColor: Color.fromRGBO(9, 9, 26, 1.0),
          canvasColor: Color.fromRGBO(9, 9, 26, 1.0),
          primaryTextTheme: Typography().white,
          textTheme: Typography().white,
          fontFamily: 'Pacifico',
        ),
      );
}
