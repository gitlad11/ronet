import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';
import 'package:ronet_engine/game_engine/splash.dart';
import 'package:window_manager/window_manager.dart';

class Game_state extends StatelessWidget{

  setFullScreen() async {
    await WindowManager.instance.setFullScreen(true);
  }


  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), setFullScreen);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Game_state_provider()),
      ],
      child: MaterialApp(
        home: Splash(image: "assets/water_fall.gif", loader_color: Colors.red ),
      ),
    );
  }
}