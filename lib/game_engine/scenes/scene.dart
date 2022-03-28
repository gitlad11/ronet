import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';


class Scene extends StatefulWidget{
  String background;
  Widget children;

  Scene({this.children = const SizedBox(), this.background = ""});

  @override
  Scene_state createState() => Scene_state();
}

class Scene_state extends State<Scene>{

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
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            widget.background.isNotEmpty ? Positioned.fill(child: Image.asset(widget.background,fit: BoxFit.fill)) : const SizedBox(),
            widget.children,
          ],
        )
    );
  }
}