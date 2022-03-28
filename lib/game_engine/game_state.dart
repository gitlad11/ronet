import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:ronet_engine/game_engine/scenes/splash.dart';
import 'package:ronet_engine/game_engine/scenes/game.dart';
import "package:ronet_engine/game_engine/components/interface_column.dart";
import 'package:ronet_engine/game_engine/components/text.dart';

class Game_state extends StatelessWidget{

  ///params

  ///components
  var interface_column1 = Positioned(
      left: 20,
      bottom: 70,
      child: Interface_column(padding_all: 8, items: [
    Label(text: "new game", font_size: 30, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
    Divider(),
    Label(text: "settings", font_size: 30, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
    Divider(),
    Label(text: "exit", font_size: 30, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
  ]));



  @override
  Widget build(BuildContext context) {

    ///scenes
    List scenes = [
      Splash(image: "assets/water_fall.gif", loader_color: Colors.red),
      Game(background: "assets/night_city_mountain.gif", children: interface_column1)
    ];

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