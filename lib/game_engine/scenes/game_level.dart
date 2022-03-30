import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';

class Game_scaffold extends StatefulWidget{

  @override
  Game_scaffold_state createState() => Game_scaffold_state();
}


class Game_scaffold_state extends State<Game_scaffold>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

    );
  }
}

class MyGameSubClass extends FlameGame {

  @override
  void render(Canvas canvas) {

  }

  @override
  void update(double dt) {

  }


}

