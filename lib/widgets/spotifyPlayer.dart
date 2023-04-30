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
  Widget _buildPlayerStateWidget() {
    return StreamBuilder<PlayerState>(
      stream: SpotifySdk.subscribePlayerState(),
      builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
        var track = snapshot.data?.track;
        var currentTrackImageUri = track!.imageUri;
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
            SpotifyImage(uri: currentTrackImageUri),
            Text(track.name),
            SpotifyPlayerControls(playerState: playerState)
          ],
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildPlayerStateWidget();
  }

}