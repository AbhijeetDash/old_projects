import 'package:eleventwos/blocs/bloc_game_engine.dart';
import 'package:eleventwos/enums/enums.dart';
import 'package:eleventwos/pages/_page_welcome.dart';
import 'package:eleventwos/widgets/_widget_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/_model_board.dart';

class PageGame extends StatefulWidget {
  final int boardSize;
  const PageGame({super.key, required this.boardSize});

  @override
  State<PageGame> createState() => _PageGameState();
}

class _PageGameState extends State<PageGame> {
  late Size size;
  late ValueNotifier<int> scoreNotifier;

  @override
  void initState() {
    context
        .read<BlocGameEngine>()
        .add(EventNewGame(boardSize: widget.boardSize));
    scoreNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: scoreNotifier,
                      builder: (context, snap, child) {
                        return Text(
                          "Score: $snap",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20.0),
                        );
                      },
                    ),
                    RawMaterialButton(
                      fillColor: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const PageWelcome(),
                        ));
                      },
                      child: const Text(
                        "Change Size",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              BlocConsumer<BlocGameEngine, GameState>(
                listener: (context, state) {},
                bloc: BlocProvider.of<BlocGameEngine>(context),
                builder: (context, state) {
                  if (state is GameStateNewGame || state is GameStatePlaying) {
                    late Board board;
                    if (state is GameStateNewGame) {
                      board = state.board;
                      scoreNotifier.value = state.board.score;
                    }

                    if (state is GameStatePlaying) {
                      board = state.board;
                      scoreNotifier.value = state.board.score;
                    }
                    return SizedBox(
                      width: size.width,
                      height: size.width,
                      child: GestureDetector(
                        onVerticalDragEnd: (details) {
                          if (details.primaryVelocity! < 0) {
                            context
                                .read<BlocGameEngine>()
                                .add(EventMove(direction: SwipeDirection.up));
                          } else if (details.primaryVelocity! > 0) {
                            context
                                .read<BlocGameEngine>()
                                .add(EventMove(direction: SwipeDirection.down));
                          }
                        },
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity! < 0) {
                            context
                                .read<BlocGameEngine>()
                                .add(EventMove(direction: SwipeDirection.left));
                          } else if (details.primaryVelocity! > 0) {
                            context.read<BlocGameEngine>().add(
                                EventMove(direction: SwipeDirection.right));
                          }
                        },
                        child: BoardWidget(
                          blocks: board.blocks,
                        ),
                      ),
                    );
                  }

                  if (state is GameStateOver) {
                    return SizedBox(
                      width: size.width,
                      height: size.width,
                      child: Stack(
                        children: [
                          BoardWidget(
                            blocks: state.board.blocks,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Game Over",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  FloatingActionButton(
                                      onPressed: () {},
                                      child: const Icon(Icons.refresh))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is GameStateWon) {
                    return SizedBox(
                      width: size.width,
                      height: size.width,
                      child: Stack(
                        children: [
                          BoardWidget(
                            blocks: state.board.blocks,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "You Won 🥳",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  FloatingActionButton(
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.refresh,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
