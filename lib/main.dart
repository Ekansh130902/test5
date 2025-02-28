import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test5/consts/styles/style.dart';
import 'package:test5/pages/home.dart';
import 'package:test5/services/providers/music_provider.dart';
import 'package:test5/services/providers/songs_provider.dart';
import 'package:test5/widgets/bottom_nav_bar.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SongsProvider()),
          ChangeNotifierProvider(create: (context)=> MusicProvider())
        ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    W = w;
    H = h;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SongsProvider())
        ],
        child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primaryTextTheme: Typography.whiteCupertino,
          // scaffoldBackgroundColor: Colors.black,
          textTheme: GoogleFonts.nunitoSansTextTheme(),
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade900,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNav()
    )
    );
  }
}

/*
Scaffold(
        appBar: AppBar(
        title: Text('Alert Widget'),
    backgroundColor: Colors.blue,
    ),
      body: Center(
        child: ElevatedButton(onPressed: (){},
            child: Text('Show Alert')
        ),
      ),
    );
 */


