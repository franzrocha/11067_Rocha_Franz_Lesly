import 'package:flutter/material.dart';

class UnlockedDoor extends StatelessWidget {
  const UnlockedDoor({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Image.asset("assets/opened_door.png", height: 2300, width: 1400);
      
  }
}