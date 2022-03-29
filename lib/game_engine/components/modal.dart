import 'package:flutter/material.dart';
import 'dart:io';

class Modal extends StatefulWidget{
  Widget children;
  late double height;
  late double width;
  late String position;
  late Color color;
  late double border_radius;
  var on_close;

  Modal({ this.children = const SizedBox(),
    this.height = 150.0,
    this.width = 300.0,
    this.position = "center",
    this.on_close,
    this.color = Colors.deepPurple,
    this.border_radius = 0.0 });

  Modal_state createState() => Modal_state();
}

class Modal_state extends State<Modal>{

  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), on_animate);
  }

  on_animate(){
    setState(() {
      animate = !animate;
    });
  }

  on_close() async {
    await on_animate();
    Future.delayed(const Duration(milliseconds: 400), widget.on_close);
  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animate ? 1 : 0,
      duration: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black26,
        child: widget.position == "center" ? Center(
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Вы точно хотите выйти?", style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      exit(0);
                    }, child:  Text("Подтвердить", style: Theme.of(context).textTheme.labelMedium)),
                    TextButton(onPressed: (){
                      on_close();
                    }, child: Text("Отмена", style: Theme.of(context).textTheme.labelMedium))
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(widget.border_radius),
              color: widget.color
            ),
          ),
        ) :  Center(
          child: Row(
            mainAxisAlignment: widget.position == "right" ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.children
            ],
          ),
        )
      ),
    );
  }
}