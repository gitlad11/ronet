import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/components/toolTip.dart';
import 'package:ronet_engine/components/component_view_item.dart';
import 'package:ronet_engine/handlers/get_scenes.dart';
import 'package:ronet_engine/providers/components_provider.dart';
import 'package:ronet_engine/providers/path_providers.dart';
import 'package:ronet_engine/providers/scenes_provider.dart';
import 'package:ronet_engine/handlers/edit.dart';

class Component_view extends StatefulWidget{

  @override
  Component_view_state createState() => Component_view_state();
}

class Component_view_state extends State<Component_view>{
  bool rename = false;
  int toolTip = 999;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  on_rename_scene() async {
    if(controller.text.isNotEmpty){
      var scene = Provider.of<Scenes_provider>(context, listen: false).current_scene;
      var renamed = await rename_scene(scene, controller.text);
      var project = Provider.of<Path_provider>(context, listen: false).path;
      if(renamed){
        var scenes = await get_scenes(project);
        await Provider.of<Scenes_provider>(context, listen: false).set_scenes(scenes);
        await Provider.of<Scenes_provider>(context, listen: false).set_current_scene(scenes[0]);
        List components = await get_components(scenes[0]);
        await Provider.of<Components_provider>(context, listen: false).set_components(components);
      }
      setState(() {
        rename = !rename;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Components_provider, Scenes_provider>(
      builder: (context, components_provider, scenes_provider, snapshot) {
        return Container(
          width: 320,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)

                    ),
                    child: Row( children: [
                      Text("Сцена: ", style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(width: 10),
                      rename ? Container(
                          height: 23,
                          width: 120,
                          child: TextField(

                            decoration: InputDecoration( hintText: scenes_provider.current_scene['name'] ),
                          )
                      ) : Text(scenes_provider.current_scene['name'], style: Theme.of(context).textTheme.labelMedium)
                    ]),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: MouseRegion(
                      onEnter: (_){
                        setState(() {
                          if(!rename){
                            toolTip = 1;
                          }
                        });
                      },
                      onExit: (_){
                        setState(() {
                          toolTip = 999;
                        });
                      },
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            rename = !rename;
                          });
                        },
                        child: Icon(rename ? Icons.close : Icons.edit, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 6,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: toolTip == 1 ? 1 : 0,
                        child: ToolTip(
                          label: "Переименовать",
                        ),
                      )
                  ),
                  rename ? Positioned(
                    top: 6,
                    right: 26,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          on_rename_scene();
                        },
                        child: const Icon(Icons.done, color: Colors.white, size: 18),
                      ),
                    ), ) : SizedBox(),
                ],
              ),
              components_provider.components.isNotEmpty ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: SizedBox(
                  height: 250,
                  child: ListView.builder(
                    itemCount: components_provider.components.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Component_view_item( label: components_provider.components[index]);
                    }),
                ),
              ) : Center( child: Text("Сцена пуста.", style : Theme.of(context).textTheme.bodyMedium)),
              Padding(
                padding: const EdgeInsets.only(bottom:  6.0),
                child: Divider(height: 4, color: Theme.of(context).scaffoldBackgroundColor),
              ),

            ],
          ),
        );
      }
    );
  }
}