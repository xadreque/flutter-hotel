import 'package:busness_in_touch/screen/empreendedora_screen.dart';
import 'package:busness_in_touch/screen/loading.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}


