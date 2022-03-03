import 'package:flutter/material.dart';
import 'package:the_great_adventure/screens/final_screen.dart';
import 'package:the_great_adventure/widgets/doors/unlocked_door.dart';

class UnlockedDoorScreen extends StatefulWidget {
  const UnlockedDoorScreen({Key? key}) : super(key: key);

  @override
  State<UnlockedDoorScreen> createState() => _UnlockedDoorScreenState();
}

class _UnlockedDoorScreenState extends State<UnlockedDoorScreen> {
  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("The door is opened!", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 50,
      ),
      body: SafeArea(
        child: Stack(children: [
          const Center(child: UnlockedDoor()),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Lock the door"),
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () async {
                    String? player = await showDialog(
                       barrierDismissible: false,
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return const PlayerNameInput();
                        });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FinalScreen(
                              player: player ?? '',
                            )));
                  },
                  child: const Text("Step through the door"),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class PlayerNameInput extends StatefulWidget {
  const PlayerNameInput({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerNameInput> createState() => _PlayerNameInputState();
}

class _PlayerNameInputState extends State<PlayerNameInput> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Please enter your name:"),
            TextFormField(
              controller: controller,
            ),
             const SizedBox(height: 10,),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text("Proceed", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }
}
