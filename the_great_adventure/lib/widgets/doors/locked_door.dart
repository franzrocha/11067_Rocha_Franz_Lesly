import 'package:flutter/material.dart';

class LockedDoor  extends StatelessWidget {
  const LockedDoor ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/closed_door.png", height: 2300, width: 1400);
      
  }
}