
import 'package:flutter/material.dart';

void main() => runApp(_MainApp());

class _MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(),
          ),
        ),
      ),
    );
  }
}