import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/components/navbar.dart';
import 'package:ronet_engine/components/folders.dart';
import 'package:ronet_engine/components/components.dart';
import 'package:ronet_engine/components/dropdown.dart';
import 'package:ronet_engine/handlers/component_dropdown.dart';
import 'package:ronet_engine/components/console.dart';
import 'package:ronet_engine/providers/size_provider.dart';

class Editor extends StatefulWidget{
  @override
  Editor_state createState() => Editor_state();
}

class Editor_state extends State<Editor>{
  int dropdown = 999;

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
                    child: DropDown()) : SizedBox(),
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
                    child: DropDown(methods: Component_dropdown())) : SizedBox(),
                dropdown == 5 ? Positioned(
                    right: 10,
                    top: 35,
                    child: DropDown()) : SizedBox(),
              ],
            ),
          );
        }
      ),
    );
  }
}