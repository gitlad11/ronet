import 'package:flutter/material.dart';

class DropDown extends StatefulWidget{
  var methods;
  DropDown({ this.methods });
  @override
  DropDown_state createState() => DropDown_state();
}

class DropDown_state extends State<DropDown>{
  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), on_animate);
  }
  on_animate(){
    setState(() {
      animate = true;
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animate ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
          ),
          ],
          borderRadius: BorderRadius.circular(6)
        ),
        child: widget.methods,
      ),
    );
  }
}