
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/components/modal.dart';
import 'package:ronet_engine/game_engine/components/text.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';

class First extends StatefulWidget{
  String background;
  Widget children;
  var transition;

  First({ this.background = '', this.children = const SizedBox(), this.transition = 'blink' });

  @override
  Scene_state createState() => Scene_state();
}

class Scene_state extends State<First>{
  bool show_modal = false;
  bool scene_appears = false;
  String dots = ".";


  setFullScreen() async {
    if(! await WindowManager.instance.isFullScreen()){
      await WindowManager.instance.setFullScreen(true);
    }
  }

  @override
  void initState() {
    setFullScreen();
    Future.delayed(const Duration(milliseconds: 200), scene_appearance);
    super.initState();
  }

  void on_modal_close(){
    setState(() {
      show_modal = false;
    });
  }

  void scene_appearance(){
    setState(() {
      scene_appears = true;
    });
  }

  void on_exit(){
    setState(() {
      show_modal = true;
    });
  }


  void scene_change(scene) async {
    setState(() {
      scene_appears = false;
    });
    await Future.delayed(const Duration(milliseconds: 300), _time_out);
    Provider.of<Game_state_provider>(context, listen: false).set_state(scene);
  }

  void update(time) async {
    await Future.delayed(Duration(milliseconds: time), _time_out);
    await on_dots();
  }

  on_dots() async {
    setState(() {
      switch(dots){
        case ".":
          dots = '..';
          break;
        case "..":
          dots = "...";
          break;
        case "...":
          dots = ".";
          break;
      }
    });
  }

  void _time_out(){
  }

  @override
  Widget build(BuildContext context) {
    update(1500);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: widget.transition == "blink" ? Colors.white : widget.transition == 'shadowing' ? Colors.black : Colors.blue
        ),
        child: AnimatedOpacity(
          opacity: scene_appears ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Stack(
            children: [
              widget.background.isNotEmpty ? Positioned.fill(child: Image.asset(widget.background,fit: BoxFit.fill)) : const SizedBox(),
              Center(
                child: Label(text : "Загрузка" + dots, font_size: 30, color: Colors.white, font_familly: "Gomawo"),
              ),
              show_modal ? Positioned.fill(child: Modal(on_close: on_modal_close, border_radius: 6,)) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
