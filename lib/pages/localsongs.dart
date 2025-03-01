import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test5/widgets/list_card.dart';

class LocalsongsScreen extends StatefulWidget {
  const LocalsongsScreen({super.key});

  @override
  State<LocalsongsScreen> createState() => _LocalsongsScreenState();
}

class _LocalsongsScreenState extends State<LocalsongsScreen> {

  @override
  void initState(){
    super.initState();
    requestPermissions();
  }

  void requestPermissions(){
    Permission.storage.request();
  }

  final _audioQuery = new OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Widget'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true
          ),
          builder: (context,item){
            if(item.data == null){
              return Center(child: CircularProgressIndicator());
            }
            else if(item.data!.isEmpty){
              return Center(child: Text('Songs not found'),);
            }
            return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context,i) => ListCard(
                  index: i,
                  banner: item.data![i].uri,
                  albumName: item.data![i].album,
                  singer: item.data![i].artist,
                  songName: item.data![i].displayName,
              )
              //     ListTile(
              //   leading: Icon(Icons.music_note),
              //   title: Text(item.data![i].displayNameWOExt),
              //   subtitle: Text(item.data![i].artist.toString()),
              // ),
            );
          }
      )

    );
  }
}
