import 'package:flutter/material.dart';
import 'package:ronet_engine/components/navbar.dart';
import 'package:ronet_engine/components/folders.dart';

class Editor extends StatefulWidget{
  @override
  Editor_state createState() => Editor_state();
}

class Editor_state extends State<Editor>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              children: [
                Navbar(),
                Row(
                  children: [
                    Folders(),

                  ],
                )
              ],
          ),
      ),
    );
  }
}