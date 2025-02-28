import 'package:flutter/material.dart';
import 'package:test5/consts/styles/style.dart';
import 'package:test5/pages/home.dart';
import 'package:test5/pages/music.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;

  PageController pageController = PageController();

  List<Widget> widgets = [
    Text('Home'),
    Text('Music'),
  ];

  void onTapped(int index){
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Navigation bar'),
      //   backgroundColor: Colors.blue,
      // ),
      body: PageView(
        controller: pageController,
        children: [
          Home(),
          MusicScreen()
        ],
      ),

        bottomNavigationBar: Container(
          height: 85,
          padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(top_right),
                  topLeft: Radius.circular(top_left)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: bottom_bar_blur_radius
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(top_left),
                topRight: Radius.circular(top_right),
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home,size: icon_size,), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.music_video_outlined,size: icon_size,), label: ""),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: selected_icon_color,
                unselectedItemColor: unselected_icon_color,
                backgroundColor: Colors.grey.shade900 ,
                type: BottomNavigationBarType.fixed,
                onTap: onTapped,

              )
            )
        )
    );
  }
}





