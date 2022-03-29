import 'package:flutter/material.dart';

class Opacity_effect extends StatefulWidget{
  late Widget children;
  late double opacity;
  late double hovered_opacity;
  late int duration;

  Opacity_effect({ this.children = const SizedBox(), this.opacity = 1.0, this.hovered_opacity = 1.0, this.duration = 500 });

  @override
  Opacity_effect_state createState() => Opacity_effect_state();
}

class Opacity_effect_state extends State<Opacity_effect>{
  bool hover = false;

  on_hover() async {
    setState(() {
      hover = true;
    });
    print(hover);
  }

  on_exit() async {
    setState(() {
      hover = false;
    });
    print(hover);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_){
        on_hover();
      },
      onExit: (_){
        on_exit();
      },
      child: AnimatedOpacity(
          opacity: hover ? widget.hovered_opacity : widget.opacity,
          duration: Duration(milliseconds : widget.duration),
          child: widget.children,
      ),
    );
  }
}