import 'package:flutter/material.dart';
import 'package:ronet_engine/handlers/get_scenes.dart';
import 'package:ronet_engine/providers/components_provider.dart';
import 'package:ronet_engine/providers/path_providers.dart';
import 'package:ronet_engine/providers/scenes_provider.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/handlers/edit.dart';

class Scenes_dropdown extends StatefulWidget{
  @override
  Scenes_dropdown_state createState() => Scenes_dropdown_state();
}

class Scenes_dropdown_state extends State<Scenes_dropdown>{

  @override
  void dispose() {

    super.dispose();
  }

  void setScene(scene) async {
      await Provider.of<Scenes_provider>(context, listen: false).set_current_scene(scene);
      List components = await get_components(scene);
      await Provider.of<Components_provider>(context, listen: false).set_components(components);
  }
  void createScene() async {
      var path = Provider.of<Path_provider>(context, listen: false).path;
      await create_scene(path);
      List scenes = await get_scenes(path + r"\flutter_project\lib\scenes");
      await Provider.of<Scenes_provider>(context, listen: false).set_scenes(scenes);
      setScene(scenes.last);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<Scenes_provider>(
      builder: (context, scene_provider, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 6, top: 6),
              child: Text("Сцены: ", style: Theme.of(context).textTheme.labelLarge),
            ),
            Container(
              width: 200,
              height: 260,
              child: ListView.builder(
                itemCount: scene_provider.scenes.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(onPressed: (){
                    setScene(scene_provider.scenes[index]);
                  }, child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(scene_provider.scenes[index]['name'], style: Theme.of(context).textTheme.labelMedium),
                  ));
                },

              ),
            ),
            TextButton(onPressed: (){
              createScene();
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Новая сцена", style: Theme.of(context).textTheme.labelLarge),
                ),
              ],
            ))
          ],
        );
      }
    );
  }
}