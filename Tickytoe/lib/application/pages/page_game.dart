import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tikytoe/application/components/component_game_scoreboard.dart';
import 'package:tikytoe/application/constants/const_colors.dart';
import 'package:tikytoe/application/constants/const_text_sizes.dart';
import 'package:tikytoe/application/pages/page_splash.dart';
import 'package:tikytoe/application/services/application_inherited_parameters.dart';
import 'package:tikytoe/application/services/application_service.dart';
import 'package:tikytoe/application/services/game_score_bloc.dart';
import 'package:tikytoe/application/views/view_game_board.dart';

class PageGame extends StatefulWidget {
  final String userMove;
  const PageGame({Key? key, required this.userMove}) : super(key: key);

  @override
  State<PageGame> createState() => _PageGameState();
}

class _PageGameState extends State<PageGame> {
  int _toss = 0;
  late Size _size;
  late AppServices _appServices;

  // To update the score and stop the game.
  final GameScoreBloc _scoreBloc = GameScoreBloc();

  // To maintain a global state of game board.
  final ValueNotifier<List<String>> _gameStateNotifier =  ValueNotifier<List<String>>(['', '', '', '', '', '', '', '', '']);

  // To notify which players turn it is.
  final ValueNotifier<bool> _playerTurnNotifier = ValueNotifier<bool>(true);

  void _makeTossDecision(){
    setState(() {
      if(_toss == 0){
        _playerTurnNotifier.value = false;
        _toss = 1;
      } else {
        _playerTurnNotifier.value = true;
        _toss = 0;
      }
    });
  }

  void _reloadGame(){
    _makeTossDecision();
    _gameStateNotifier.value = ['', '', '', '', '', '', '', '', ''];
    _appServices = AppServices(widget.userMove);
  }

  void _navigateToPage(Widget page){
    Get.offAll(
          () => page,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 600),
      transition: Transition.leftToRight,
    );
  }

  @override
  void initState() {
    _appServices = AppServices(widget.userMove);
    _makeTossDecision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () async => false,
      child: Tikytoe(
        gameStateNotifier: _gameStateNotifier,
        appServices: _appServices,
        playerTurnNotifier: _playerTurnNotifier,
        userMove: widget.userMove,
        gameScoreBloc: _scoreBloc,

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.0),
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                _navigateToPage(const PageSplash());
              },
              icon: const Icon(Icons.arrow_back_ios, color: textColor),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultSpaceHeight),
                child: SizedBox(
                  width: 100,
                  child: Image.asset("assets/icon.png"),
                ),
              ),
              const SizedBox(height: 20.0),
              _toss == 1?const Text("You have the first move"): const Text("AI has the first move"),
              const SizedBox(height: 20.0),
              ComponentGameScoreBoard(reloadGame: _reloadGame),
              const SizedBox(height: 30.0),
              ViewGameBoard(
                currentGameState: _gameStateNotifier.value,
              ),
              const SizedBox(height: 50.0),
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
                ),
                color: Colors.white,
                  child: IconButton(
                    onPressed: (){
                      _reloadGame();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
              ),
              const SizedBox(height: 10.0),
              const Text("Tap to toss again")
            ],
          ),
        ),
      ),
    );
  }
}
