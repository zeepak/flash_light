import 'package:flutter/material.dart';
import '../component/development.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: mediaWidth == 0 || mediaHeight == 0
          ? const Center(
              // Show loading text when mediaquery returns 0
              child: Text('Loading...'),
            )
          : Development(
              mediaWidth: mediaWidth,
              mediaHeight: mediaHeight,
            ),
    );
  }
}