import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';
import 'package:ronet_engine/game_engine/scenes/first.dart';
import 'package:ronet_engine/game_engine/scenes/settings.dart';
import 'package:window_manager/window_manager.dart';
import 'package:ronet_engine/game_engine/scenes/splash.dart';
import 'package:ronet_engine/game_engine/scenes/game.dart';
import "package:ronet_engine/game_engine/components/interface_column.dart";
import 'package:ronet_engine/game_engine/components/text.dart';
import 'package:ronet_engine/game_engine/components/hover_effect.dart';

class Game_parameters extends StatefulWidget{
  late List scenes;

  ///params
  bool splash_full_screen = false;
  int splash_show_time = 4;
  bool full_screen = true;
  bool show_status = false;
  bool show_windows_bar = false;
  String status = '';

  Game_parameters({this.scenes = const []});

  @override
  Game_parameters_state createState() => Game_parameters_state();
}


class Game_parameters_state extends State<Game_parameters>{

  @override
  void initState() {
    Provider.of<Game_state_provider>(context, listen: false).init_game(
        widget.splash_full_screen,
        widget.full_screen,
        widget.splash_show_time);
    if(widget.show_windows_bar == false){
      WindowManager.instance.setTitleBarStyle("hidden");
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<Game_state_provider>(
        builder: (context, game_state_provider, snapshot) {
          return widget.scenes[game_state_provider.state];
        }
    );
  }
}


class Game_state extends StatefulWidget{

  @override
  State<Game_state> createState() => _Game_state_state();
}

class _Game_state_state extends State<Game_state> {


  ///components
  var interface_column1 = Positioned(
      left: 20,
      bottom: 70,
      child: Column(
        children: [
     Opacity_effect(
           opacity: 1.0,
           hovered_opacity: 0.7,
           children:  Label(text: "new game", font_size: 30, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
     ),
    const Divider(),
            Opacity_effect(
              opacity: 1.0,
              hovered_opacity: 0.7,
              children:  Label(text: "settings", font_size: 30, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
            ),
          const   Divider(),
            Opacity_effect(
              opacity: 1.0,
              hovered_opacity: 0.7,
              children:  Label(text: "help", font_size: 30, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
            ),
    const Divider(),
            Opacity_effect(
              opacity: 1.0,
              hovered_opacity: 0.7,
              children:  Label(text: "exit", font_size: 30, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
            ),
      ]
      ));

  @override
  Widget build(BuildContext context) {

    ///scenes
    List scenes = [
      Splash(image: "assets/water_fall.gif", fill_image: false, images: [
        "assets/dart.png",
        "assets/flame_engine.png"
      ], loader_color: Colors.red),
      Game(background: "assets/night_city_mountain.gif", children: interface_column1),
      Settings(background: "assets/water_fall.gif", ),
      First(background: "assets/night_city_mountain.gif",),
    ];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Game_state_provider()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFD50B49)),
            scaffoldBackgroundColor: const Color(0xFF212121),
            backgroundColor: const Color(0xFF313131),
            primaryColor: Colors.black,
            iconTheme: const IconThemeData().copyWith(color: Colors.white),
            fontFamily: 'Montserrat',
            textTheme: TextTheme(
              headline2: const TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              headline4: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[300],
                fontWeight: FontWeight.w500,
                letterSpacing: 2.0,
              ),
              bodyText1: TextStyle(
                color: Colors.grey[300],
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
              bodyText2: TextStyle(
                color: Colors.grey[300],
                letterSpacing: 1.0,
              ),
            ),
          ),
        home: Game_parameters(scenes : scenes)
      ),
    );
  }
}
