import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/components/tabs.dart';
import 'package:ronet_engine/providers/size_provider.dart';

class Game_view extends StatefulWidget{

  @override
  Game_view_state createState() => Game_view_state();
}

class Game_view_state extends State<Game_view>{

  @override
  Widget build(BuildContext context) {
    double content_width = MediaQuery.of(context).size.width - 360.0;
    double content_height = MediaQuery.of(context).size.height - 60.0;
    return Consumer<Size_provider>(
      builder: (context, size_provider, snapshot) {
        return Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.front_hand, size: 20),
                      ),
                    ),
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.mouse, size: 20),
                      ),
                    ),
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.height, size: 20),
                      ),
                    ),
                  ],
                ),
                Container(
                    height: 30,
                    width: content_width,
                    child: Tabs()
                ),
                Flexible(
                  child: Container(
                    width: content_width,
                    color: Colors.blueAccent,

                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}