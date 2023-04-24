import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyImage extends StatefulWidget {
  const SpotifyImage({super.key, required this.uri});

  final ImageUri uri;
  
  @override
  State<StatefulWidget> createState() => _SpotifyImageState();
}

class _SpotifyImageState extends State<SpotifyImage> {
  var logger = Logger();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: SpotifySdk.getImage(
      imageUri: widget.uri,
      dimension: ImageDimension.large,  
    ),
    builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
      if (snapshot.hasData) {
            return Image.memory(snapshot.data!);
          } else if (snapshot.hasError) {
            logger.d(snapshot.error.toString());
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Error getting image')),
            );
          } else {
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Getting image...')),
            );
          }
    }
  );
  }
}