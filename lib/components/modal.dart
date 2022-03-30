import 'package:flutter/material.dart';

class Modal extends StatefulWidget{
  Widget children;

  Modal({this.children = const SizedBox() });

  @override
  Modal_state createState() => Modal_state();
}

class Modal_state extends State<Modal>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: Center(
          child: Container(
            width: 300,
            height: 160,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).backgroundColor
            ),
            child:  widget.children
          ),
      )
    );
  }
}