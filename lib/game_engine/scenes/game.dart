import 'package:flutter/material.dart';
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
    await WindowManager.instance.setFullScreen(true);
  }

  @override
  void initState() {
    setFullScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black
      ),
      child: Stack(
        children: [
          widget.background.isNotEmpty ? Positioned.fill(child: Image.asset(widget.background,fit: BoxFit.fill)) : const SizedBox(),
          widget.children
        ],
      ),
    );

  }
}