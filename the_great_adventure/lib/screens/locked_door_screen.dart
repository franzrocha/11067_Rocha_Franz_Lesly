import 'package:flutter/material.dart';
import 'package:the_great_adventure/screens/door_unlock_screen.dart';
import 'package:the_great_adventure/screens/unlocked_door_screen.dart';
import 'package:the_great_adventure/widgets/doors/locked_door.dart';

class LockedDoorScreen extends StatefulWidget {
  const LockedDoorScreen({Key? key}) : super(key: key);

  @override
  State<LockedDoorScreen> createState() => _LockedDoorScreenState();
}

class _LockedDoorScreenState extends State<LockedDoorScreen> {
  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("You see a ${isUnlocked ? 'unlocked' : 'locked'} door", style: const TextStyle(fontSize: 20),),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 50,
      ),
      body: SafeArea(
        
        child: Stack(children: [
          const Center(child: LockedDoor()),
          Center(
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () async {
                if (isUnlocked) {
                  bool? reLockDoor = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const UnlockedDoorScreen()));
                  if (reLockDoor ?? false) {
                    if (mounted) {
                      setState(() {
                        isUnlocked = false;
                      });
                    }
                  }
                } else {
                  bool? result = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const DoorLockScreen()));
                  if (result ?? false) {
                    if (mounted) {
                      setState(() {
                        isUnlocked = true;
                      });
                    } else {
                      if (mounted) {
                        setState(() {
                          isUnlocked = false;
                        });
                      }
                    }
                  }
                }
              },
              child: Text(isUnlocked ? "Open Door" : "Examine Door"),
            ),
          ),
        ]),
      ),
    );
  }
}
