import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LocalSongsProvider extends ChangeNotifier{
  final _audioQuery = new OnAudioQuery();
  List<dynamic> localSongs = [];

  fetchLocalSongs () async{

  }

}