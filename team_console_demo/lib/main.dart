import 'package:flutter/material.dart';

import 'package:team_console_demo/login.dart';

void main() => runApp(MyApp());

final String domain = "192.168.0.123:3000";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
