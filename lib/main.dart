import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      home: const MyHomePage(title: 'Hello World'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Album {
  final int id;
  final String title;
  final String image;

  const Album({
    required this.id,
    required this.title,
    required this.image
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      image: json['images[0].url']
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String message = "";
  String apiToken = "";

  // Send a POST request to Spotify API to get the access token for future request
  fetchToken () async {
    final response = await http.post(
      Uri.parse("https://accounts.spotify.com/api/token"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      },
      body: "grant_type=client_credentials&client_id=7bc59922129e42de95166c07c8ca48e5&client_secret=4b77fefe87a74b6eb0d9089a736616c3",
    );

    final responseJson = jsonDecode(response.body);
    apiToken = responseJson["access_token"];
  }

  // Send a GET request to Spotify API to get Artist data such as cover page, name, or top tracks
  Future<http.Response> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/artists/2YZyLoL8N0Wb9xBt1NhZWg?si=EIqa6vYGRtevLbO8v1soWg'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer  $apiToken"
      }
    );
    final responseJson = jsonDecode(response.body);

    final imageText = responseJson["images"][0]['url'];
    print(responseJson["images"][0]['url']);
    setState(() {
      message = imageText.toString();
    });    
    return response;
  }

  // Fetches the Token upon building the application
  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(message)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchAlbum,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
