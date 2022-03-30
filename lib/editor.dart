import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/components/modal.dart';
import 'package:ronet_engine/components/navbar.dart';
import 'package:ronet_engine/components/folders.dart';
import 'package:ronet_engine/handlers/edit.dart';
import 'package:ronet_engine/components/components.dart';
import 'package:ronet_engine/components/dropdown.dart';
import 'package:ronet_engine/handlers/component_dropdown.dart';
import 'package:ronet_engine/components/console.dart';
import 'package:ronet_engine/handlers/scenes_dropdown.dart';
import 'package:ronet_engine/providers/path_providers.dart';
import 'package:ronet_engine/providers/scenes_provider.dart';
import 'package:ronet_engine/providers/size_provider.dart';

class Editor extends StatefulWidget{
  @override
  Editor_state createState() => Editor_state();
}

class Editor_state extends State<Editor>{
  int dropdown = 999;
  bool show_modal = false;
  int modal = 999;
  int component = 999;

  TextEditingController controller = TextEditingController();

  setDropDown(index){
    setState(() {
      dropdown = index;
    });
  }
  leaveDropDown(){
    setState(() {
      dropdown = 999;
    });
  }

  addComponent(type) async {
    var path = Provider.of<Path_provider>(context, listen: false).path;
    var scene = Provider.of<Scenes_provider>(context, listen: false).current_scene;

    await add_component(scene, path, controller.text + '.dart', type);
    on_close_modal();
  }
  on_show_modal(int index, int c) async {

    setState(() {
      show_modal = true;
      component = c;
    });
    await Future.delayed(const Duration(milliseconds: 100), _timeout);
    setState(() {
      modal = index;
    });
  }

  on_close_modal() async {
    setState(() {
      modal = 999;
    });
    await Future.delayed(const Duration(milliseconds: 500), _timeout);
    setState(() {
      show_modal = false;
    });
  }

  _timeout(){

  }

  @override
  Widget build(BuildContext context) {

    double content_width = MediaQuery.of(context).size.width - 360.0;

    return Scaffold(
      body: Consumer<Size_provider>(
        builder: (context, size_provider, snapshot) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(

              children: [
                Positioned.fill(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          children: [
                            Navbar(leaveDropDown: leaveDropDown, setDropDown: setDropDown),
                            MouseRegion(
                              onEnter: (_){
                                if(dropdown != 999){
                                  leaveDropDown();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Folders(),
                                  Container(
                                    width: size_provider.side_width >= content_width ? 20 : content_width - size_provider.side_width,
                                    height: MediaQuery.of(context).size.height - 45,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(),
                                        Console()
                                      ],
                                    ),
                                  ),
                                  Components(),
                                ],
                              ),
                            ),
                          ],
                      ),
                  ),
                ),
                dropdown == 1 ? Positioned(
                    left: 10,
                    top: 35,
                    child: DropDown(methods: Component_dropdown(items: const [ "Новый проект", "Открыть проект"] ),)) : SizedBox(),
                dropdown == 2 ? Positioned(
                    left: 140,
                    top: 35,
                    child: DropDown()) : SizedBox(),
                dropdown == 3 ? Positioned(
                    left: 220,
                    top: 35,
                    child: DropDown()) : SizedBox(),
                dropdown == 4 ? Positioned(
                    right: 140,
                    top: 35,
                    child: DropDown(methods: Component_dropdown(
                      items: const ["Пустой элемент", "Box collider", "Камера", "Sprite анимация", "Звук", "Gif эффект", "Gif фон", "Текст"],
                      method: on_show_modal,
                      icons: const [Icons.question_mark, Icons.square_sharp, Icons.videocam_rounded, Icons.animation, Icons.surround_sound, Icons.gif, Icons.gif, Icons.text_format],
                    ))) : SizedBox(),
                dropdown == 5 ? Positioned(
                    right: 10,
                    top: 35,
                    child: DropDown(methods: Scenes_dropdown())) : SizedBox(),
                show_modal ? Positioned.fill(
                    child: AnimatedOpacity(
                      opacity: modal == 1 ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Modal(
                        children: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Название", style: Theme.of(context).textTheme.titleMedium),
                            TextField( controller: controller, ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(onPressed: (){
                                  if(controller.text.isNotEmpty){
                                    addComponent(component);
                                  }
                                }, child: Text("Подтвердить", style: Theme.of(context).textTheme.labelLarge,)),
                                const SizedBox(width: 20),
                                TextButton(onPressed: (){
                                  on_close_modal();
                                }, child: Text("Отмена", style: Theme.of(context).textTheme.labelLarge,),)
                              ],
                            )
                          ],
                        ),
                      )
                    )) : const SizedBox()
              ],
            ),
          );
        }
      ),
    );
  }
}