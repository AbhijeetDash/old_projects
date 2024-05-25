import 'package:flutter/material.dart';
import 'package:tikytoe/application/services/application_service.dart';
import 'package:tikytoe/application/services/game_score_bloc.dart';

class Tikytoe extends InheritedWidget {
  final ValueNotifier<List<String>> gameStateNotifier;
  final ValueNotifier<bool> playerTurnNotifier;
  final GameScoreBloc gameScoreBloc;
  final AppServices appServices;
  final String userMove;


  const Tikytoe({
    Key? key,
    required Widget child,
    required this.gameStateNotifier,
    required this.appServices,
    required this.playerTurnNotifier,
    required this.gameScoreBloc,
    required this.userMove,
  }) : super(key: key, child: child);

  static Tikytoe of(BuildContext context) {
    final Tikytoe? result =
        context.dependOnInheritedWidgetOfExactType<Tikytoe>();
    assert(result != null, 'No Tikytoe found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Tikytoe old) {
    return false;
  }
}
