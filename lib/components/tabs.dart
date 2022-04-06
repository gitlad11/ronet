import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/components/tab.dart';
import 'package:ronet_engine/providers/scenes_provider.dart';

class Tabs extends StatefulWidget{
  @override
  Tabs_state createState() => Tabs_state();
}

class Tabs_state extends State<Tabs>{
  @override
  Widget build(BuildContext context) {
    return Consumer<Scenes_provider>(
      builder: (context, scenes, snapshot) {
        return ListView.builder(
          itemCount: scenes.opened_scenes.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Tab_item(index: index, name: scenes.opened_scenes[index]["name"], path: scenes.opened_scenes[index]["path"], current: scenes.current_scene['name'], );
          },
        );
      }
    );
  }
}