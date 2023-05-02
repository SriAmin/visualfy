// spotifyAuth.dart
// This houses the widget that handles authentication and connection to the Spotify SDK
// With a given connection callback, it'll call it if connection to the Spotify SDK is succussfull

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

  //Call the connectToSpotifyRemote function from the Spotify SDK
  Future<void> connectToSpotifyRemote() async {
    try {
      //Get the result from the connection request, if succussfull, use the connection callback paremeter, otherwise log the error
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
    // Show an elevated button that contains text and a spotify image
    return ElevatedButton(
      onPressed: connectToSpotifyRemote, 
      style: ElevatedButton.styleFrom(
        elevation: 5
      ),
      child: Container (
        width: MediaQuery.of(context).size.width - 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Connect to Spotify"),
            const Padding(padding: EdgeInsets.all(5.0)),
            Image.network(
              "https://www.citypng.com/public/uploads/small/11661570403whwxybsmx9s49gydvycyvydsof4sqok0xk0cisomyqi9tvzojomgsfwp1ffra1pqt5ndii64wnwpzmkqsvjr7wkuh3fpukvy2eki.png",
              width: 30,  
            )
          ],
        ),
      )
    );
  }
}

