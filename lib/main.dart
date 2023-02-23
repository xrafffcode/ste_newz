import 'package:ste_newz/state_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ste_newz/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      navigatorKey: Get.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: sort_child_properties_last
      child: const Center(
        // ignore: unnecessary_const
        child: const Image(
          image: AssetImage('assets/image/splash.png'),
          height: 500,
        ),
      ),
      padding: const EdgeInsets.all(40),
      color: Colors.green[400],
    );
  }
}
