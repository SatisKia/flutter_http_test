import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  String responseData = "";

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0
      ),
      body: Column( children: [
        SizedBox(
            width: contentWidth,
            height: contentWidth / 8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: onPressed,
                child: Text(
                  "GET",
                  style: TextStyle( fontSize: contentWidth / 16 ),
                )
            )
        ),
        SizedBox(
            width: contentWidth,
            height: contentHeight - contentWidth / 8,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: <Widget>[
                      Text( responseData )
                    ]
                )
            )
        )
      ] ),
    );
  }

  void onPressed() async {
    String url = "http://www5d.biglobe.ne.jp/~satis/flutter_test.txt";
    http.Response response = await http.get( Uri.parse(url) );
    setState(() {
//      responseData = response.body;
      responseData = const Utf8Decoder().convert( response.bodyBytes );
    });
  }
}
