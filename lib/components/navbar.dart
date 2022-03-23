import 'package:flutter/material.dart';
import 'package:ronet_engine/components/navbar_item.dart';

class Navbar extends StatelessWidget{
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
          Row(
            children: [
              Navbar_item(title: "Проект"),
              Navbar_item(title: "Отладчик"),
              Navbar_item(title: "Помощь"),
            ],
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
                Navbar_item(title: "Компоненты", icon : Icons.square_foot),
                Navbar_item(title: "Сцены", icon: Icons.layers),
                SizedBox(width: 20)
              ])
        ],
      ),
    );
  }
}