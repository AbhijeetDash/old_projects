import 'package:eleventwos/blocs/bloc_game_engine.dart';
import 'package:eleventwos/pages/_page_welcome.dart';
import 'package:eleventwos/utils/_util_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // register all the classes before the app starts
  UtilsLocator().setupLocator();

  runApp(const ElevenTwos());
}

class ElevenTwos extends StatefulWidget {
  const ElevenTwos({super.key});

  @override
  State<ElevenTwos> createState() => _ElevenTwosState();
}

class _ElevenTwosState extends State<ElevenTwos> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlocGameEngine(),
      child: MaterialApp(
        title: 'Eleven Twos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PageWelcome(),
      ),
    );
  }
}
