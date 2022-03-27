import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:ronet_engine/game_engine/scenes/splash.dart';
import 'package:ronet_engine/game_engine/scenes/game.dart';

class Game_state extends StatelessWidget{

  ///params


  ///scenes
  List scenes = [
    Splash(image: "assets/water_fall.gif", loader_color: Colors.red),
    Game(background: "assets/night_city_mountain.gif")
  ];

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Game_state_provider()),
      ],
      child: MaterialApp(
        home: Consumer<Game_state_provider>(
          builder: (context, game_state_provider, snapshot) {
              return scenes[game_state_provider.state];
          }
        ),
      ),
    );
  }
}