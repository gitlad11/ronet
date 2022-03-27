import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';

class Splash extends StatefulWidget{
  late String image;
  late String loader_image;
  late double loader_size;
  late List loader_position;
  late bool show_status = false;
  late String loader_type;
  late Color loader_color;
  late bool show_loader;
  late Widget children;
  late int show_time;
  Splash({ this.image = '', this.loader_image = '', this.loader_position = const [30.0, 30.0],
            this.loader_size = 30.0, this.loader_type = "circular", this.loader_color = Colors.redAccent,
            this.show_loader = true, this.children = const SizedBox(), this.show_time = 6 });

  @override
  Splash_state createState() => Splash_state();
}

class Splash_state extends State<Splash>{
  bool animate = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), handle_animate);
    Future.delayed(Duration(seconds: widget.show_time), splash_end);
    super.initState();
  }

  handle_animate(){
    setState(() {
      animate = !animate;
    });
  }

  splash_end() async {
    await Future.delayed(const Duration(milliseconds: 700), handle_animate);
    Provider.of<Game_state_provider>(context, listen: false).set_state(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        opacity: animate ? 1 : 0,
        duration: const Duration(milliseconds: 700),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset(widget.image, fit: BoxFit.fill,)),
              Positioned(
                  right: widget.loader_position[0],
                  bottom: widget.loader_position[1],
                  child: Container(
                    width: widget.loader_size,
                    height: widget.loader_size,
                    child: CircularProgressIndicator(
                      color: widget.loader_color,

                    ),
                  )
              ),
              widget.children
            ],
          ),
        ),
      ),
    );
  }
}