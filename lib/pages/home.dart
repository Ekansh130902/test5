import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test5/consts/colors/color.dart';
import 'package:test5/consts/strings/string.dart';
import 'package:test5/consts/styles/style.dart';
import 'package:test5/services/providers/songs_provider.dart';
import 'package:test5/widgets/card.dart';
import 'package:test5/widgets/list_card.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // initialize and fetch songs
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<SongsProvider>(context, listen: false);

      // Fetch only if not already loading, once fetched, don't fetch again
      if (!provider.isLoading) {
        provider.fetchLocalSongs();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final songsProvider = Provider.of<SongsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Pic
              Container(
                // color: Colors.red,
                child: CircleAvatar(
                  backgroundImage: AssetImage(user_pic),
                  maxRadius: 25,
                ),
              ),

              // User
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                    userName,
                    style: userNameStyle,
                  )),
                  Container(
                      child: Text(
                    gold_member,
                    style: goldMemberStyle,
                  ))
                ],
              ),

              // Notify Icon
              Icon(
                Icons.notifications_none,
                color: notify_icon_color,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            listen_latest_music,
                            style: listen_latest_style,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 10), // Optional spacing
                              Expanded(
                                child: TextField(
                                  // remove borderline
                                  decoration: InputDecoration(
                                    hintStyle: search_music_style,
                                    hintText: search_music,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(recently_played,style: recently_played_style,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [CardWidget(), CardWidget(), CardWidget()],
                    ),
                    Text(recommend_for_you,style: recommended_style,),
                  ],
                ),
              ),

              /// ListView.builder to show songs
              songsProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true, // Makes ListView adapt to content height
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: songsProvider.songs.length,
                      itemBuilder: (context, i) => ListCard(
                        banner: songsProvider.songs[i].genre,
                        songName: songsProvider.songs[i].title,
                        singer: songsProvider.songs[i].artist,
                        albumName: songsProvider.songs[i].album,
                        index: i,
                      )
                    ),
            ],
          ),
        ));
  }
}

/*
  https://free-music-api2.vercel.app/getSongs
 */
