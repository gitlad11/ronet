import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/components/modal.dart';
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
              Image.asset("assets/sparks.gif", height: 30, width: 30,),
              Positioned(
                bottom: 50,
                left: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(2),
                      width: MediaQuery.of(context).size.width - 200,
                      decoration:  BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 46,
                              width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.amber, Colors.orange, Colors.deepOrange])
                            ),
                            ),
                          Image.asset("assets/sparks.gif", height: 48, width: 48,),
                        ],
                      ),

                    )
                  ],
                ),
              ),
              show_modal ? Positioned.fill(child: Modal(on_close: on_modal_close, border_radius: 6,)) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}