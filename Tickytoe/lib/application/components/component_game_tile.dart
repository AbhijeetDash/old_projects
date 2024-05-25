import 'package:flutter/material.dart';
import 'package:tikytoe/application/services/application_inherited_parameters.dart';
import 'package:tikytoe/application/services/application_service.dart';
import 'package:tikytoe/application/services/game_score_bloc.dart';

class ComponentGameTile extends StatefulWidget {
  final int index;

  const ComponentGameTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ComponentGameTile> createState() => _ComponentGameTileState();
}

class _ComponentGameTileState extends State<ComponentGameTile> {
  bool _disable = false;
  late ValueNotifier<List<String>> _gameStateNotifier;
  late AppServices _appServices;
  late ValueNotifier<bool> _playerTurnNotifier;
  late GameScoreBloc _scoreBloc;

  void _makeMove() {
    if (!_disable) {
      _appServices.makeHumanMove(
        widget.index,
        _gameStateNotifier,
        _playerTurnNotifier,
        _scoreBloc,
      );
      _disable = true;
    }
  }

  void _tileTapControl(List<String> value) {
    if (value[widget.index] == "") {
      _disable = false;
    } else {
      _appServices.checkWinner(_gameStateNotifier.value);
      _disable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Getting all required variables from Inherited Widget
    _gameStateNotifier = Tikytoe.of(context).gameStateNotifier;
    _appServices = Tikytoe.of(context).appServices;
    _playerTurnNotifier = Tikytoe.of(context).playerTurnNotifier;
    _scoreBloc = Tikytoe.of(context).gameScoreBloc;

    return InkWell(
      onTap: () {
        // Make intended move
        _makeMove();
      },
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _gameStateNotifier,
        builder: (context, value, child) {
          // Check if the tile is tap enabled
          _tileTapControl(value);

          return Card(
            elevation: 3.0,
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: value[widget.index] == "x"
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset("assets/x.png"))
                    : value[widget.index] == "o"
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/o.png"))
                        : Container(),
              ),
            ),
          );
        },
      ),
    );
  }
}
