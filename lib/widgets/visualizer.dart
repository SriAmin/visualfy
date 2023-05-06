import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Visualizer extends StatefulWidget {
  final String trackId;

  const Visualizer({super.key, required this.trackId});

  @override
  State<StatefulWidget> createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  Logger logger = new Logger();
  late List<double> _frequencyData;
  late double _samplingRate;

  Future<Map<String, dynamic>> _getTrackData(String trackId) async {

    String accessToken = "";

    final token = await http.post(
      Uri.parse("https://accounts.spotify.com/api/token"),
      headers: {
        "Content-Type": 'application/x-www-form-urlencoded'
      },
      body: {
        "grant_type" : "client_credentials",
        "client_id" : "7bc59922129e42de95166c07c8ca48e5",
        "client_secret" : "4b77fefe87a74b6eb0d9089a736616c3"
      }
    );

    if (token.statusCode == 200) {
      var body = json.decode(token.body);
      accessToken = body['access_token'];
    } else {
      throw Exception("Failed to access Spotify API token");
    }

    final response = await http.get(
      Uri.parse("https://api.spotify.com/v1/tracks/$trackId"),
      headers: {
        "Authorization": 'Bearer $accessToken'
      }
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load track data");
    }
  }

  @override
  void initState() {
    super.initState();
    _frequencyData = List.filled(100, 0.0);
    _samplingRate = 44100;
    _getTrackData(widget.trackId).then((trackData) {
      final previewUrl = trackData['preview_url'];
      logger.d(trackData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}