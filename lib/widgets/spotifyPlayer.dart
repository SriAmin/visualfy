import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:visualfy/widgets/spotifyImage.dart';

class SpotifyPlayer extends StatefulWidget {
  const SpotifyPlayer({super.key});
  
  @override
  State<SpotifyPlayer> createState() => _SpotifyPlayerState();
}

class _SpotifyPlayerState extends State<SpotifyPlayer> {
  var logger = Logger();

  bool _isPaused = false;

  Future<void> play() async {
    try {
      await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
      setState(() {
        _isPaused = false;
      });
    } on PlatformException catch (e) {
      logger.d("Error Code: ${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      logger.d("Error Code: ${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      logger.d("Error Code: ${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  Widget _buildPlayerStateWidget() {
    return StreamBuilder<PlayerState>(
      stream: SpotifySdk.subscribePlayerState(),
      builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
        var track = snapshot.data?.track;
        var currentTrackImageUri = track?.imageUri;
        var playerState = snapshot.data;
        if (playerState == null || track == null) {
          return Center(
            child: Container(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SpotifyImage(uri: track.imageUri),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: skipPrevious, 
                  child: const Icon(Icons.skip_previous)
                ),
                playerState.isPaused 
                  ?
                    TextButton(
                      onPressed: resume, 
                      child: const Icon(Icons.play_arrow)
                    )
                  :
                    TextButton(
                      onPressed: pause, 
                      child: const Icon(Icons.pause)
                    ),
                TextButton(
                  onPressed: skipNext, 
                  child: const Icon(Icons.skip_next)
                ),
              ],
            ),
          ],
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildPlayerStateWidget();
  }

}