import 'package:flutter/material.dart';
import 'package:tikytoe/application/components/component_game_tile.dart';
import 'package:tikytoe/application/services/application_inherited_parameters.dart';
import 'package:tikytoe/application/services/application_service.dart';
import 'package:tikytoe/application/services/game_score_bloc.dart';

class ViewGameBoard extends StatefulWidget {
  final List<String> currentGameState;
  const ViewGameBoard({
    Key? key,
    required this.currentGameState,
  }) : super(key: key);

  @override
  State<ViewGameBoard> createState() => _ViewGameBoardState();
}

class _ViewGameBoardState extends State<ViewGameBoard> {
  late ValueNotifier<List<String>> _gameStateNotifier;
  late ValueNotifier<bool> _playerTurnNotifier;
  late AppServices _appServices;
  late GameScoreBloc _scoreBloc;
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _gameStateNotifier = Tikytoe.of(context).gameStateNotifier;
    _playerTurnNotifier = Tikytoe.of(context).playerTurnNotifier;
    _appServices = Tikytoe.of(context).appServices;
    _scoreBloc = Tikytoe.of(context).gameScoreBloc;
    _size = MediaQuery.of(context).size;


    return ValueListenableBuilder<bool>(
        valueListenable: _playerTurnNotifier,
        builder: (context, value, child) {
          if (value) {
            _playerTurnNotifier.value = false;
            _appServices.makeBotMove(_gameStateNotifier, _scoreBloc, _playerTurnNotifier);
          }
          return SizedBox(
            width: _size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    ComponentGameTile(
                      index: 0,
                    ),
                    SizedBox(width: 10.0),
                    ComponentGameTile(
                      index: 1,
                    ),
                    SizedBox(width: 10.0),
                    ComponentGameTile(
                      index: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ComponentGameTile(
                      index: 3,
                    ),
                    SizedBox(width: 10.0),
                    ComponentGameTile(
                      index: 4,
                    ),
                    SizedBox(width: 10.0),
                    ComponentGameTile(
                      index: 5,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ComponentGameTile(
                      index: 6,
                    ),
                    SizedBox(width: 10.0),
                    ComponentGameTile(
                      index: 7,
                    ),
                    SizedBox(width: 10.0),
                    ComponentGameTile(
                      index: 8,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
