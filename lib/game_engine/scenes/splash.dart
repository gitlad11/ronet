import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/game_engine/providers/game_state_provider.dart';
import 'package:window_manager/window_manager.dart';

class Splash extends StatefulWidget{
  late String image;
  late List images;
  late String loader_image;
  late double loader_size;
  late List loader_position;
  late bool show_status = false;
  late String loader_type;
  late Color loader_color;
  late bool show_loader;
  late Widget children;
  late bool fill_image;
  Splash({ this.image = '', this.loader_image = '', this.loader_position = const [30.0, 30.0],
            this.loader_size = 30.0, this.loader_type = "circular", this.loader_color = Colors.redAccent,
            this.show_loader = true, this.children = const SizedBox(), this.images = const [], this.fill_image = true });

  @override
  Splash_state createState() => Splash_state();
}

class Splash_state extends State<Splash>{
  bool animate = false;
  int image_index = 0;
  int show_time = 3;

  @override
  void initState() {
    show_time = Provider.of<Game_state_provider>(context, listen: false).splash_show_time;
    bool screen = Provider.of<Game_state_provider>(context, listen: false).splash_full_screen;
    if(screen){
      setFullScreen();
    }

    Future.delayed(const Duration(milliseconds: 200), handle_animate);

    if(widget.images.isEmpty){
      Future.delayed(Duration(seconds: show_time), splash_end);
    } else {
      Future.delayed(Duration(seconds: show_time), next_image);
    }
    super.initState();
  }

  handle_animate() {
    setState(() {
      animate = !animate;
     });
  }

  splash_end() async {
    handle_animate();
    await Future.delayed(const Duration(milliseconds: 700), Provider.of<Game_state_provider>(context, listen: false).set_state(1));
  }

  setFullScreen() async {
    if(! await WindowManager.instance.isFullScreen()){
      await WindowManager.instance.setFullScreen(true);
    }
  }

  next_image() async {
    if(widget.images.length > image_index){
      for(var image in widget.images){
        handle_animate();
        await Future.delayed(const Duration(milliseconds: 900),
                (){ setState(() {
              widget.image = widget.images[image_index];
              image_index = image_index + 1;
            }); });
        handle_animate();
        await  Future.delayed(Duration(seconds: show_time), next_image);
      }
    } else {
      splash_end();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        opacity: animate ? 1 : 0,
        duration: const Duration(milliseconds: 900),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              widget.fill_image ? Positioned.fill(child: Image.asset(widget.image, fit: BoxFit.fill)) :
              Positioned.fill(
                  child: Center(
                child: Image.asset(widget.image, height: 260, width: 260),
              )),
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