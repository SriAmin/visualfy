// spotifyPlayer.dart
// This file handles the Spotify Information and Media Controls, this allows users to perform several functions
// as well as seeing the image, and title of the currently playing track

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:visualfy/widgets/spotifyImage.dart';

import 'spotifyPlayerControls.dart';

class SpotifyPlayer extends StatefulWidget {
  const SpotifyPlayer({super.key});
  
  @override
  State<SpotifyPlayer> createState() => _SpotifyPlayerState();
}

class _SpotifyPlayerState extends State<SpotifyPlayer> {

  //Sets up a Stream to the Spotify Player, this will listen to changes to the users spotfiy account to translate them here
  Widget _buildPlayerStateWidget() {
    return StreamBuilder<PlayerState>(
      stream: SpotifySdk.subscribePlayerState(),
      builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
        //Grab the currently playing track's data along with the current state of the media player
        var track = snapshot.data?.track;
        var currentTrackImageUri = track!.imageUri;
        var playerState = snapshot.data;

        if (playerState == null || track == null) {
          return Center(
            child: Container(),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SpotifyImage(uri: currentTrackImageUri),
            Column(
              children: <Widget>[
                //This will shortern the string of the title if its too long
                Text(
                  track.name.substring(0, min(track.name.length, 48)),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                SpotifyPlayerControls(playerState: playerState)
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