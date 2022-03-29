import 'package:flutter/material.dart';
import 'package:ronet_engine/game_engine/components/hover_effect.dart';
import 'package:ronet_engine/game_engine/components/interface_column.dart';
import 'package:ronet_engine/game_engine/components/modal.dart';
import 'package:ronet_engine/game_engine/components/text.dart';
import 'package:window_manager/window_manager.dart';
import "package:ronet_engine/components/search_modal.dart";

class Game extends StatefulWidget{
  String background;
  var children;

  Game({ this.background = '', this.children });

  @override
  Game_state_widget createState() => Game_state_widget();
}


class Game_state_widget extends State<Game>{
  bool show_modal = false;

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

  void on_close(){
    setState(() {
      show_modal = false;
    });
  }

  on_exit(){
    setState(() {
      show_modal = true;
    });
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
              left: 70,
              bottom: 100,
              child: Column(
              children: [
              Opacity_effect(
              opacity: 1.0,
              hovered_opacity: 0.7,
              children:  Label(text: "new game", font_size: 40, font_familly: "Gomawo", stack: false, opacity: 1, color: Colors.white, weight: FontWeight.w600,),
              ),
                Divider( height: 20 ),
              Opacity_effect(
              opacity: 1.0,
              hovered_opacity: 0.7,
              children:  Label(text: "settings", font_size: 40, font_familly: "Gomawo", stack: false, opacity: 1, color: Colors.white, weight: FontWeight.w600,),
              ),
                Divider( height: 20 ),
              Opacity_effect(
              opacity: 1.0,
              hovered_opacity: 0.7,
              children:  Label(text: "help", font_size: 40, font_familly: "Gomawo", stack: false, opacity: 1, color: Colors.white, weight: FontWeight.w600,),
              ),
                Divider( height: 20 ),
              Opacity_effect(
              opacity: 1.0,
              hovered_opacity: 0.7,
              children:  Label(text: "exit", font_size: 40, font_familly: "Gomawo", stack: false, opacity: 1, color: Colors.white, weight: FontWeight.w600, onTap: on_exit),
              ),
              ]
              )),
            show_modal ? Positioned.fill(child: Modal(on_close: on_close, border_radius: 6,)) : const SizedBox()
          ],
        ),
      ),
    );

  }
}