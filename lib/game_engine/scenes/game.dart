import 'package:flutter/material.dart';
import 'package:ronet_engine/game_engine/components/interface_column.dart';
import 'package:ronet_engine/game_engine/components/text.dart';
import 'package:window_manager/window_manager.dart';
import "package:ronet_engine/components/search_modal.dart";

class Game extends StatefulWidget{
  String background;
  Widget children;

  Game({ this.background = '', this.children = const SizedBox() });

  @override
  Game_state createState() => Game_state();
}


class Game_state extends State<Game>{

  setFullScreen() async {
    if(! await WindowManager.instance.isFullScreen()){
      await WindowManager.instance.setFullScreen(true);
    }
  }

  @override
  void initState() {
    setFullScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Stack(
          children: [
            widget.background.isNotEmpty ? Positioned.fill(child: Image.asset(widget.background,fit: BoxFit.fill)) : const SizedBox(),
            Positioned(
                left: 40,
                bottom: 70,
                child: Column( children: [
                  Label(text: "new game", font_size: 36, margin: 15.0, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
                  Divider(),
                  Label(text: "settings", font_size: 36, margin: 15.0, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
                  Divider(),
                  Label(text: "exit", font_size: 36, margin: 15.0, font_familly: "Gomawo", stack: false, opacity: 0.8, color: Colors.white),
                ]))
          ],
        ),
      ),
    );

  }
}