
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:test5/services/providers/music_provider.dart';
import 'package:test5/services/providers/songs_provider.dart';

import '../consts/styles/style.dart';

class MusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);
    final songsProvider = Provider.of<SongsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: W,
          child: Stack(
            children: [
              Center(child: Text('Audio Widget', style: title_style,)),
              Positioned(
                right: 0,
                child: Icon(Icons.favorite_rounded, color: Colors.white,size: 25,),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image(
                  image: NetworkImage(songsProvider.songs[musicProvider.currentIndex]['songBanner']),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.music_note, size: 150)
                ),
              ),
            ),
          ),
          /// 🎵 Display Current Song Name
          Text(
            songsProvider.songs.isNotEmpty
                ? songsProvider.songs[musicProvider.currentIndex]['songName'] ?? "Unknown Song"
                : "No song selected",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          /// 🔊 Progress Bar
          StreamBuilder<Duration>(
            stream: musicProvider.player.positionStream,
            builder: (context, snapshot) {
              final progress = snapshot.data ?? Duration.zero;
              final total = musicProvider.player.duration ?? Duration.zero;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProgressBar(
                  progress: progress,
                  total: total,
                  onSeek: (duration) => musicProvider.player.seek(duration),
                ),
              );
            },
          ),

          /// 🎶 Playback Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () => musicProvider.playPrevious(context),
              ),
              StreamBuilder<PlayerState>(
                stream: musicProvider.player.playerStateStream,
                builder: (context, snapshot) {
                  final playing = snapshot.data?.playing ?? false;
                  return IconButton(
                    icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                    iconSize: 64,
                    onPressed: () {
                      playing ? musicProvider.player.pause() : musicProvider.player.play();
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () => musicProvider.playNext(),
              ),
            ],
          ),

          /// 🔄 Shuffle & Repeat Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shuffle, color: musicProvider.isShuffling ? Colors.blue : Colors.grey),
                onPressed: musicProvider.toggleShuffle,
              ),
              IconButton(
                icon: Icon(Icons.repeat, color: musicProvider.isRepeating ? Colors.blue : Colors.grey),
                onPressed: musicProvider.toggleRepeat,
              ),
            ],
          ),
        ],
      ),
    );
  }
}














/*

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test5/consts/styles/style.dart';


class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer();
  }

  Future<void> _setupAudioPlayer() async{  // place uri for selecting multiple playlist
    _player.playbackEventStream.listen(
            (event){},
        onError: (Object e, StackTrace stacktrace){
          print("A Stream error occured $e");
        }
    );
    try{
      _player.setAudioSource(AudioSource.uri(Uri.parse("https://samplelib.com/lib/preview/mp3/sample-15s.mp3")));
      // await _player.setAudioSource(AudioSource.asset("/assets/audio/music.mp3"));
    }
    catch(e){
      print("Error loading Audio source: $e");
    }
  }

  Widget _playbackControlButton(){
    return StreamBuilder<PlayerState>(stream: _player.playerStateStream,
        builder: (context,snapshot){
          final processingState = snapshot.data?.processingState;
          final playing = snapshot.data?.playing;
          if(processingState == ProcessingState.loading  ||  processingState == ProcessingState.buffering){
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 40,
              height: 40,
              child: CircularProgressIndicator(color: Colors.white,),
            );
          }
          else if(playing != true){  // music is Currently stop
            return IconButton(
              onPressed: _player.play,
              icon: Icon(Icons.play_arrow),
              iconSize: 64,
            );
          }
          else if(processingState != ProcessingState.completed){  // running state
            return IconButton(
              onPressed: _player.pause,
              icon: Icon(Icons.pause),
              iconSize: 64,
            );
          }
          else{
            return IconButton(
              onPressed: ()=>_player.seek(Duration.zero),
              icon: Icon(Icons.replay),
              iconSize: 64,
            );
          }
          return Container();
        });
  }

  Widget _progressBar(){
    return StreamBuilder<Duration?>(
        stream: _player.positionStream,
        builder: (context,snapshot){
          return ProgressBar(
            progress: snapshot.data ?? Duration.zero,
            total: _player.duration  ??  Duration.zero,
            onSeek: (duration){
              _player.seek(duration);
            },
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      body: Container(
          // color: Colors.red,
          child:
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image(
                        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScP9qYljmEGe5IgCOuPxKpWtd4kcR1X7LnSQ&s',),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text('Ophelia', style: songname_style,),
                SizedBox(height: 20,),
                Text('Steven Price', style: artistname_style,),
                SizedBox(height: 30,),
                _progressBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // _controlButtons(),
                    Icon(Icons.shuffle, size: ct_size,),
                    Icon(Icons.skip_previous_outlined, size: ct_size,),
                    CircleAvatar(
                      backgroundColor: Color(0xFF6156E2),
                      child: _playbackControlButton(),
                      radius: 40,
                    ),

                    Icon(Icons.skip_next, size: ct_size,),
                    Icon(Icons.repeat, size: ct_size,)
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
 */


/*


 */

