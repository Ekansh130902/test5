import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test5/consts/styles/style.dart';
import 'package:test5/services/providers/music_provider.dart';

class ListCard extends StatelessWidget {
  final String? banner;
  final String? songName;
  final String? singer;
  final String? albumName;
  final index;
  const ListCard({Key? key, required this.index, this.banner, this.songName, this.singer, this.albumName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: GestureDetector(
        onTap: () => musicProvider.playSong(context, index),
        child: Row(
          children: [
            Container(
              height: 88,
              width: 88,
              margin: EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  banner!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.music_note, size: 50),
                ),
              ),
            ),

            // Song Details
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songName ?? 'Unknown Song',
                    style: list_card_songname_style,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    singer ?? 'Unknown Artist',
                    style: list_card_artist_style,
                  ),
                  SizedBox(height: 4),
                  Text(
                    albumName ?? 'Unknown Album',
                    style: list_card_playlist_style,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
