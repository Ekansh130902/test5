import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test5/consts/strings/string.dart';
import 'package:http/http.dart' as http;


class SongsProvider extends ChangeNotifier {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _songs = [];
  bool _isLoading = false;
  bool _hasFetched = false;

  List<SongModel> get songs => _songs;
  bool get isLoading => _isLoading;

  /// Request Permissions & Fetch Songs
  Future<void> fetchLocalSongs() async {
    if (_hasFetched) return; // Avoid multiple fetches

    _isLoading = true;
    notifyListeners();

    // Request storage permissions
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      print("Storage permission denied");
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Fetch songs from device storage
    try {
      _songs = await _audioQuery.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      _hasFetched = true;
      print("Local songs fetched successfully");
    } catch (e) {
      print("Error fetching local songs: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}


/*
class SongsProvider extends ChangeNotifier{

  List<dynamic> _songs = [];
  bool _isLoading = false;
  bool _hasFetched = false;

  List<dynamic> get songs => _songs;
  bool get isLoading => _isLoading;

  void fetchSongs() async {
    if (_hasFetched) return;

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(base_Url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _songs = json.decode(response.body);
        _hasFetched = true;
        print("Songs fetch successfully");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

}
*/