import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyPlayerControls extends StatefulWidget {  
  const SpotifyPlayerControls({super.key, required this.playerState});

  final PlayerState playerState;

  @override
  State<StatefulWidget> createState() => _SpotifyPlayerControlState();
}

class _SpotifyPlayerControlState extends State<SpotifyPlayerControls> {
  var logger = Logger();

  Future<void> play() async {
    try {
      await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
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
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  Future<void> shuffle(bool shuffle) async {
    try {
      await SpotifySdk.setShuffle(
        shuffle: shuffle,
      );
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d('not implemented');
    }
  }

  Future<void> repeat(bool repeatSwitch) async {
    try {
      await SpotifySdk.setRepeatMode(
        repeatMode: repeatSwitch ? RepeatMode.track : RepeatMode.off,
      );
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d('not implemented');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch.adaptive(
                  value: widget.playerState.playbackOptions.repeatMode.index == 0 ? false : true, 
                  onChanged: (bool repeatSwitch) => repeat(repeatSwitch)
                ),
                TextButton(
                  onPressed: skipPrevious, 
                  child: const Icon(Icons.skip_previous)
                ),
                widget.playerState.isPaused 
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
                Switch.adaptive(
                  value: widget.playerState.playbackOptions.isShuffling, 
                  onChanged: (bool shuffleSwitch) => shuffle(shuffleSwitch)
                )
              ],
            );
    }

}