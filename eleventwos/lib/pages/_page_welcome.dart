import 'package:eleventwos/blocs/bloc_game_engine.dart';
import 'package:eleventwos/pages/_page_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageWelcome extends StatefulWidget {
  const PageWelcome({super.key});

  @override
  State<PageWelcome> createState() => _PageWelcomeState();
}

class _PageWelcomeState extends State<PageWelcome> {
  int boardSize = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "2^11",
              style: TextStyle(fontSize: 90.0, fontWeight: FontWeight.w900),
            ),
            const Text(
              "A Simple 2048 Game",
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 50.0),
            // Drop down button to select the board size
            const Text(
              "Select board size.",
              style: TextStyle(fontSize: 14.0),
            ),
            DropdownButton<int>(
              value: boardSize,
              underline: Container(),
              items: const [
                DropdownMenuItem(
                  value: 4,
                  child: Text("4x4", style: TextStyle(fontSize: 20.0)),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text("5x5", style: TextStyle(fontSize: 20.0)),
                ),
                DropdownMenuItem(
                  value: 6,
                  child: Text("6x6", style: TextStyle(fontSize: 20.0)),
                ),
                DropdownMenuItem(
                  value: 7,
                  child: Text("7x7", style: TextStyle(fontSize: 20.0)),
                ),
                DropdownMenuItem(
                  value: 8,
                  child: Text("8x8", style: TextStyle(fontSize: 20.0)),
                ),
              ],
              onChanged: (value) {
                boardSize = value!;
                setState(() {});
              },
            ),
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: RawMaterialButton(
                shape: const StadiumBorder(),
                fillColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => PageGame(
                        boardSize: boardSize,
                      ),
                    ),
                  );
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "PLAY",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
