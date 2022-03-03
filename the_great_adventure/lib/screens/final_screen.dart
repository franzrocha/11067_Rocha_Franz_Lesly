import 'package:flutter/material.dart';

class FinalScreen extends StatelessWidget {
  final String player;
  const FinalScreen({this.player = '', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/final_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/celebrating.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 10),
            Text(
              "You made it outside $player, congratulations!",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 32),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
