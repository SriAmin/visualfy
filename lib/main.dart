// main.dart
// Purpose of this application is to intiate the application and be the home for all elements related to the application,
// This file is ran first upon the application startup

import 'package:flutter/material.dart';
import 'package:visualfy/widgets/spotifyPlayer.dart';
import 'widgets/spotifyAuth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Set the App Bar to show the App Title
      appBar: AppBar(
        title: const Text("Visualfy"),
      ),
      body: Center(
        child: Column(
          //If Connected, align the elements to the end if connected, otherwise center it
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //If Connected, show the Spotify Media Player, otherwise show the Spotify Auth Button
            _connected ?
              Column(children: const <Widget>[
                SpotifyPlayer(),
                Padding(padding: EdgeInsets.all(15)),
              ],)
              :
              SpotifyAuth(onConnect: (){
                setState(() {
                  _connected = true;
                });
              }),
          ],
        ),
      ),
    );
  }
}
