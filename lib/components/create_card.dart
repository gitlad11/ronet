import 'package:flutter/material.dart';

class Create_card extends StatefulWidget{
  late String image;
  late String name;
  late int index;
  late int chosenItem;
  var choseItem;

  Create_card({ this.image = '', this.name = '', this.index = 0, this.chosenItem= 0, this.choseItem});

  @override
  Create_card_state createState() => Create_card_state();
}

class Create_card_state extends State<Create_card>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.choseItem(widget.index);
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 200,
            height: 180,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: widget.index == widget.chosenItem ? Colors.blue.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
                border: widget.index == widget.chosenItem ? Border.all(color: Colors.blueAccent) : Border.all(color: Colors.black12)
            ),
            child: Center(
              child: Image.asset(widget.image, height: 90, width: 90),
            ),
          ),
          const SizedBox(height: 10),
          Text(widget.name, style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}