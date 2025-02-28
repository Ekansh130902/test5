import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test5/services/providers/music_provider.dart';

class ListCard extends StatelessWidget {
  final Map<String, dynamic> songData;
  final index;

  const ListCard({Key? key, required this.songData, required this.index}) : super(key: key);

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
                  songData['songBanner'],
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
                    songData['songName'] ?? 'Unknown Song',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    songData['singer'] ?? 'Unknown Artist',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    songData['albumname'] ?? 'Unknown Album',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
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
