import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:test5/main.dart';
import 'songs_provider.dart';

class MusicProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  int _currentIndex = 0;
  bool _isShuffling = false;
  bool _isRepeating = false;
  List<int> _recentSongs = [];

  /// Getters
  AudioPlayer get player => _player;
  int get currentIndex => _currentIndex;
  bool get isShuffling => _isShuffling;
  bool get isRepeating => _isRepeating;

  MusicProvider() {
    _listenForSongCompletion();
  }

  void _listenForSongCompletion() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  // Play a song by index
  Future<void> playSong(BuildContext context, int index) async {
    final songsProvider = Provider.of<SongsProvider>(context, listen: false);
    if (songsProvider.songs.isEmpty) return;

    _currentIndex = index;
    _updateRecentSongs(index);

    await _player.setAudioSource(
      AudioSource.uri(Uri.parse(songsProvider.songs[index]['url'])),
    );
    _player.play();
    notifyListeners();
  }

  void _updateRecentSongs(int index) {
    // Remove if already exists
    _recentSongs.remove(index);

    // Add to the front
    _recentSongs.insert(0, index);

    // Max only 3 songs
    if (_recentSongs.length > 3) {
      _recentSongs.removeLast();
    }

    notifyListeners();
  }

  // Play next song
  // void playNext(BuildContext context) {
  //   final songsProvider = Provider.of<SongsProvider>(context, listen: false);
  //   if (songsProvider.songs.isEmpty) return;
  //
  //   if (_isShuffling) {
  //     _currentIndex = (DateTime.now().millisecondsSinceEpoch % songsProvider.songs.length);
  //   } else {
  //     _currentIndex = (_currentIndex + 1) % songsProvider.songs.length;
  //   }
  //   playSong(context, _currentIndex);
  // }

  void playNext() {
    final songsProvider = Provider.of<SongsProvider>(navigatorKey.currentContext!, listen: false);
    if (songsProvider.songs.isEmpty) return;

    if (_isRepeating) {
      playSong(navigatorKey.currentContext!, _currentIndex);
      return;
    }

    if (_isShuffling) {
      _currentIndex = (DateTime.now().millisecondsSinceEpoch % songsProvider.songs.length);
    } else {
      _currentIndex = (_currentIndex + 1) % songsProvider.songs.length;
    }

    playSong(navigatorKey.currentContext!, _currentIndex);
  }


  /// Play previous song
  void playPrevious(BuildContext context) {
    final songsProvider = Provider.of<SongsProvider>(context, listen: false);
    if (songsProvider.songs.isEmpty) return;

    _currentIndex = (_currentIndex - 1) < 0 ? songsProvider.songs.length - 1 : _currentIndex - 1;
    playSong(context, _currentIndex);
  }

  /// Toggle shuffle
  void toggleShuffle() {
    _isShuffling = !_isShuffling;
    notifyListeners();
  }

  /// Toggle repeat
  void toggleRepeat() {
    _isRepeating = !_isRepeating;
    _player.setLoopMode(_isRepeating ? LoopMode.one : LoopMode.off);
    notifyListeners();
  }
}
