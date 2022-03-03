import 'package:flutter/material.dart';
import 'package:the_great_adventure/screens/locked_door_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: Container(
         decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/start_background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 32),
                 
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/adventure_icon.png",
                        height: 100,
                        width: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Welcome to The Great Adventure!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                        
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LockedDoorScreen(),
                        ),
                      );
                    },
                    child: const Text("Let's go!", style: TextStyle(color: Colors.white),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
