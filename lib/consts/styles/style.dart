import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test5/consts/colors/color.dart';

double W = 0;
double H = 0;

// bottom navigation bar
double icon_size = 30;
double bottom_bar_blur_radius = 20;
double top_left = 40;
double top_right = 40;

// control buttons
double ct_size = 30;

FontWeight fw6 = FontWeight.w600;
FontWeight fw4 = FontWeight.w400;

// User
TextStyle userNameStyle = TextStyle(fontWeight: fw6, fontSize: 18,letterSpacing: 0.24, color: F2);
TextStyle goldMemberStyle = TextStyle(fontWeight: fw4, fontSize: 14,letterSpacing: 0.24, color: DE);


/// Home Screen
TextStyle listen_latest_style = TextStyle(fontWeight: fw6,fontSize: 26, color: F2);

// search music
TextStyle search_music_style = TextStyle(fontWeight: fw4,fontSize: 14,color: E8);

// Recently played Section
TextStyle recent_song_style = TextStyle(color: F2,fontWeight: fw4,fontSize: 14,);
TextStyle recently_played_style = TextStyle(color: F2,fontWeight: fw6,fontSize: 22);

// recommended for you
TextStyle recommended_style = TextStyle(color: F2, fontSize: 18,fontWeight: fw6);

/// Audio Screen

// Audio
TextStyle title_style = TextStyle(fontSize: 24,fontWeight: fw6);
TextStyle songname_style = TextStyle(fontSize: 24, fontWeight: fw4,color: F2);
TextStyle artistname_style = TextStyle(fontSize: 18, fontWeight: fw4, color: E8);
TextStyle au_songname_style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

/// List Card

TextStyle list_card_songname_style = TextStyle(fontSize: 16, fontWeight: fw4, color: F2);
TextStyle list_card_artist_style = TextStyle(fontSize: 13, fontWeight: fw4,color: DE);
TextStyle list_card_playlist_style = TextStyle(fontSize: 13, fontWeight: fw4,color: DE);

