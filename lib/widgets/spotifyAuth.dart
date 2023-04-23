import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyAuth extends StatefulWidget {
  const SpotifyAuth({super.key});

  @override
  State<SpotifyAuth> createState() => _SpotifyAuthState();
}

class _SpotifyAuthState extends State<SpotifyAuth>{
  var logger = Logger();

  bool _loading = false;
  bool _connected = false;

  Future<void> connectToSpotifyRemote() async {
    try {
      setState(() { _loading = true; });

      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: "7bc59922129e42de95166c07c8ca48e5",
          redirectUrl: "spotify-ios-quick-start://spotify-login-callback");
      
      result ? logger.d("Connection to Spotify Successfull") : logger.d("Connecting to Spotify Unsuccessful");
      
      setState(() {_loading = false; });

    } on PlatformException catch (e) {
      setState(() { _loading = false; });
      logger.d("Error Code: $e: ${e.message}");

    } on MissingPluginException {
      setState(() { _loading = false; });
      logger.d("Not Implemented");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
                  onPressed: connectToSpotifyRemote, 
                child: const Icon(Icons.settings_remote)
      );
  }
}

