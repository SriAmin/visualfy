import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyAuth extends StatefulWidget {
  final Function()? onConnect;

  const SpotifyAuth({super.key, this.onConnect});

  @override
  State<SpotifyAuth> createState() => _SpotifyAuthState();
}

class _SpotifyAuthState extends State<SpotifyAuth>{
  var logger = Logger();

  Future<void> connectToSpotifyRemote() async {
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: "7bc59922129e42de95166c07c8ca48e5",
          redirectUrl: "spotify-ios-quick-start://spotify-login-callback");
      
      if (result) {
        logger.d("Connection to Spotify Successfull");
        widget.onConnect?.call();
      } else {
        logger.d("Connecting to Spotify Unsuccessful");
      }
      
    } on PlatformException catch (e) {
      logger.d("Error Code: ${e.code}: ${e.message}");
    } on MissingPluginException {
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

