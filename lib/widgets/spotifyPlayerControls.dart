// spotifyPlayerControls.dart
// This file handles all media controls of the spotify player, you'd be able to pause, resume
// skip next, skip previous, shuffle and repeat. This will also request the player state from it's
// parent Widget to alter the UI based on its values

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyPlayerControls extends StatefulWidget {  
  const SpotifyPlayerControls({super.key, required this.playerState});

  //Required parameter of the player state of the connected Spotify Player
  final PlayerState playerState;

  @override
  State<StatefulWidget> createState() => _SpotifyPlayerControlState();
}

class _SpotifyPlayerControlState extends State<SpotifyPlayerControls> {
  var logger = Logger();

  // Function will call on the Spotify SDK to pause the currently playing track
  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  // Function will call on the Spotify SDK to resume the currently playing track
  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  // Function will call on the Spotify SDK to skip to the next song in the queue
  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  // Function will call on the Spotify SDK to skip to the previous song, or restart it based on songs position
  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      logger.d("${e.code}: ${e.message}");
    } on MissingPluginException {
      logger.d("Not Implemented");
    }
  }

  // Function will call on the Spotify SDK to set the shuffle mode of the player, true will shuffle, false will turn it off
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

  // Function will call on the Spotify SDK to set the repeat mode of the player, true will repeat the track, false will turn it off
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
    //Determines the shuffle mode of the track to alter the UI of the media player
    var isShuffling = widget.playerState.playbackOptions.isShuffling;

    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: skipPrevious, 
                  child: const Icon(Icons.skip_previous)
                ),
                // If the track is currently paused, show the resume button, and vice versa
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
                //If the shuffle mode is off, make the button grey, if its on, show the button as green and active
                isShuffling
                ?
                TextButton(onPressed: () => shuffle(false), child: const Icon(Icons.shuffle, color: Colors.green))
                :
                TextButton(onPressed: () => shuffle(true), child: const Icon(Icons.shuffle, color: Colors.grey))
              ],
            );
    }

}