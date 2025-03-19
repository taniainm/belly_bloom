import 'package:flutter/material.dart';
import 'landingpage.dart';
import 'login.dart';
import 'signup.dart';

void main() {
  runApp(MaterialApp(
    title: 'BellyBloom',
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => HalamanSatu(),
      '/signup': (BuildContext context) => SignUpPage(),
    },
  ));
}
