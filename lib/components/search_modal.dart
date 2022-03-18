import 'package:flutter/material.dart';
import 'dart:io';

class Search_modal extends StatefulWidget{
  List items;
  var go_to_directory;
  Search_modal({ this.items = const [], this.go_to_directory });

  @override
  Search_modal_state createState() => Search_modal_state();
}

class Search_modal_state extends State<Search_modal>{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 160,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6)
        ),
        color: const Color(0xFF313131)
      ),
      child: widget.items.isNotEmpty ? ListView.builder(
          itemCount: widget.items.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index){
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: (){
                    widget.go_to_directory(widget.items[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Expanded(child: Text(widget.items[index], overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium)),
                  )
              ),
            );
          }
      ) : Center( child: Text("список пуст...", style: Theme.of(context).textTheme.bodyMedium),),
    );
  }
}