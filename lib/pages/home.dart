import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test5/consts/strings/string.dart';
import 'package:test5/consts/styles/style.dart';
import 'package:test5/services/providers/songs_provider.dart';
import 'package:test5/widgets/card.dart';
import 'package:test5/widgets/list_card.dart';


// apne pc pr github se login kr lena

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<SongsProvider>(context, listen: false);
      if (!provider.isLoading) { // ✅ Fetch only if not already loading
        provider.fetchSongs();
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
                // crossAxisAlignment: CrossAxisAlignment.,
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

              // Ghanta
              Icon(
                Icons.notifications_none,
                color: notify_icon_color,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          // ✅ Makes the entire screen scrollable
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
                                  decoration: InputDecoration(
                                    hintText: "Search Music Here",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(recently_played),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [CardWidget(), CardWidget(), CardWidget()],
                    ),
                    Text(recommend_for_you),
                  ],
                ),
              ),

              /// ✅ Place ListView.builder **outside** the Column
              songsProvider.isLoading
                  ? Center(
                      child: CircularProgressIndicator()) // Show loading state
                  : ListView.builder(
                      shrinkWrap:
                          true, // ✅ Makes ListView adapt to content height
                      physics:
                          NeverScrollableScrollPhysics(), // ✅ Prevents nested scrolling
                      itemCount: songsProvider.songs.length,
                      itemBuilder: (context, i) => ListCard(songData: songsProvider.songs[i], index: i,)
                    ),
            ],
          ),
        ));
  }
}

/*
  https://free-music-api2.vercel.app/getSongs
 */
