import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:test5/consts/strings/string.dart';
import 'package:http/http.dart' as http;

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

    final url = Uri.parse(base_Url);  // Replace with actual API URL
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