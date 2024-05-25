import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/_util_color_map.dart';

class BoardWidget extends StatefulWidget {
  final List<List<Tile>> blocks;

  const BoardWidget({
    super.key,
    required this.blocks,
  });

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  late Size size;

  double get _blockSize =>
      (size.width - (5 * widget.blocks.length - 1) - 41) / widget.blocks.length;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < widget.blocks.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < widget.blocks.length; j++)
                  Container(
                    width: _blockSize,
                    height: _blockSize,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: blockColors.containsKey(widget.blocks[i][j].value)
                          ? blockColors[widget.blocks[i][j].value]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        widget.blocks[i][j].value == 0
                            ? ""
                            : widget.blocks[i][j].value.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            )
        ],
      ),
    );
  }
}
