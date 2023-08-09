import 'package:flutter/material.dart';

import 'auth/loginPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(kwetu());
}

class kwetu extends StatefulWidget {
  const kwetu({Key? key}) : super(key: key);

  @override
  State<kwetu> createState() => _kwetuState();
}

class _kwetuState extends State<kwetu> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginPage(),
    );
  }
}
