import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/components/modal.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';

class Scene extends StatefulWidget{
  String background;
  Widget children;
  var transition;
  Scene({ this.background = '', this.children = const SizedBox(), this.transition = 'shadowing' });

  @override
  Scene_state createState() => Scene_state();
}

class Scene_state extends State<Scene>{
  bool show_modal = false;
  bool scene_appears = false;

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
  void _time_out(){
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            widget.background.isNotEmpty ? Positioned.fill(child: Image.asset(widget.background,fit: BoxFit.fill)) : const SizedBox(),
            widget.children,
            show_modal ? Positioned.fill(child: Modal(on_close: on_modal_close, border_radius: 6,)) : const SizedBox()
          ],
        )
    );
  }
}