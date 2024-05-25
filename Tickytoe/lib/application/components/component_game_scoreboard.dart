
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikytoe/application/models/model_game_score.dart';
import 'package:tikytoe/application/services/application_inherited_parameters.dart';
import 'package:tikytoe/application/services/game_score_bloc.dart';

class ComponentGameScoreBoard extends StatefulWidget {
  final GestureTapCallback reloadGame;
  const ComponentGameScoreBoard({Key? key, required this.reloadGame}) : super(key: key);

  @override
  State<ComponentGameScoreBoard> createState() =>
      _ComponentGameScoreBoardState();
}

class _ComponentGameScoreBoardState extends State<ComponentGameScoreBoard> {
  int p1 = 0, p2 = 0;
  late GameScoreBloc _scoreBloc;

  @override
  Widget build(BuildContext context) {
    _scoreBloc = Tikytoe.of(context).gameScoreBloc;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "AI",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 15.0),
        Card(
          elevation: 5.0,
          shape: const StadiumBorder(),
          child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _scoreBloc.gameScoreStream,
                builder: (context, snap) {
                  GameScore _addedScore  = GameScore(scorePlayerOne: 0, scorePlayerTwo: 0);
                  if(snap.hasData){
                    _addedScore = snap.data as GameScore;
                    p1 += _addedScore.scorePlayerOne;
                    p2 += _addedScore.scorePlayerTwo;
                    _scoreBloc.gameScoreSink.add(GameScore(scorePlayerOne: 0, scorePlayerTwo: 0));
                  }
                  return Text("$p1 - $p2");
                }
              )),
        ),
        const SizedBox(width: 15.0),
        const Text(
          "You",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
    //   }
    // );
  }
}
