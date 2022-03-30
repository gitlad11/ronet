import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:ronet_engine/game_engine/components/hover_effect.dart';
import 'package:ronet_engine/game_engine/components/modal.dart';
import 'package:ronet_engine/game_engine/components/text.dart';
import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget{
  String background;
  Widget children;
  var transition;
  Settings({ this.background = '', this.children = const SizedBox(), this.transition = 'shadowing' });

  @override
  Settings_state createState() => Settings_state();
}

class Settings_state extends State<Settings>{
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
    Future.delayed(const Duration(milliseconds: 150), scene_appearance);
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
              Center(
                child : Container(
                  width: 320,
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity_effect(
                          opacity: 1.0,
                          hovered_opacity: 0.7,
                          children:  Label(text: "game progress", font_size: 40, font_familly: "Gomawo", stack: false, opacity: 1, color: Colors.white, weight: FontWeight.w600,),
                        ),
                        Divider( height: 20 ),
                        Opacity_effect(
                          opacity: 1.0,
                          hovered_opacity: 0.7,
                          children:  Label( onTap: () {  }, text: "controllers", font_size: 40, font_familly: "Gomawo", stack: false, opacity: 1, color: Colors.white, weight: FontWeight.w600,),
                        ),
                        Divider( height: 20 ),
                      ]
                  ),
                ),
              ),
              Positioned(
                  bottom: 30,
                  left: 30,
                  child: Opacity_effect(
                    opacity: 1.0,
                    hovered_opacity: 0.7,
                    children:  Label( onTap: () { scene_change(1); }, text: "back", font_size: 40, font_familly: "Gomawo", stack: false, opacity: 1, color: Colors.white, weight: FontWeight.w600,),
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