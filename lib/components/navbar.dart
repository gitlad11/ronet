import 'package:flutter/material.dart';
import 'package:ronet_engine/components/navbar_item.dart';

class Navbar extends StatelessWidget{
  var setDropDown;
  var leaveDropDown;

  Navbar({this.setDropDown, this.leaveDropDown });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
          color: const Color(0xFF313131)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 30,
            width: 300,
            child: Row(
              children: [
                Navbar_item(title: "Проект", setDropDown: setDropDown, leaveDropDown: leaveDropDown, index: 1),
                Navbar_item(title: "Отладчик",setDropDown: setDropDown, leaveDropDown: leaveDropDown, index: 2),
                Navbar_item(title: "Помощь", setDropDown: setDropDown, leaveDropDown: leaveDropDown, index: 3),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){},
                  child: const Icon(Icons.play_arrow, size: 26),
                ),
              ),
              const SizedBox(width: 60),
            ],
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Navbar_item(title: "Компоненты", icon : Icons.square_foot, setDropDown: setDropDown, leaveDropDown: leaveDropDown, index: 4),
                Navbar_item(title: "Сцены", icon: Icons.layers, setDropDown: setDropDown, leaveDropDown: leaveDropDown, index: 5),
                SizedBox(width: 20)
              ])
        ],
      ),
    );
  }
}