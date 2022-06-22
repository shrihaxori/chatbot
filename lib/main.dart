//import 'package:chatbot/domain/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:chatbot/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FC',
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
    );
  }
}
