import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ronet_engine/components/directory_item.dart';

import 'package:ronet_engine/handlers/get_directories.dart';


class Directories extends StatefulWidget{
  late List items;
  var go_to_directory;

  Directories({ required this.items, required this.go_to_directory });

  @override
  Directories_state createState() => Directories_state();
}

class Directories_state extends State<Directories>{



  @override
  Widget build(BuildContext context) {
        return Container(
          width: 300,
          height: 250,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
                      itemCount: widget.items.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                        return Directory_item(name : widget.items[index]['name'], path : widget.items[index]['path'], type: widget.items[index]['type'], empty: widget.items[index]['empty'], onClick: widget.go_to_directory);
                      })
        );

  }
}