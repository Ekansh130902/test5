import 'package:flutter/material.dart';
import 'package:test5/consts/styles/style.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 81,
          width: 101,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScP9qYljmEGe5IgCOuPxKpWtd4kcR1X7LnSQ&s'),
            width: 100,height: 100, fit: BoxFit.cover,)
          ),
        ),
        Text('Carl Mikson',style: recent_song_style)
      ],
    );
  }
}









/*

 Text("Recently Played", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                /// 🎶 Display Each Recently Played Song (Using Indexes)
                for (int index in musicProvider.recentSongs)
                  ListTile(
                    leading: songsProvider.songs[index]['imageUrl'] != null
                        ? Image.network(songsProvider.songs[index]['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.music_note, size: 50),
                    title: Text(songsProvider.songs[index]['songName']),
                    subtitle: Text(songsProvider.songs[index]['artist'] ?? "Unknown Artist"),
                    onTap: () {
                      musicProvider.playSong(context, index);
                    },
                  ),

 */

