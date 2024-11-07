import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state/board_cubit.dart';
import 'ui/base_grid.dart';
import 'ui/home_area.dart';
import 'ui/win_area.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    super.key,
  });
  final unit = 10.0;
  final homeMulti = 6;
  final whiteMulti = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: LayoutBuilder(builder: (context, constraints) {
          const int gridCount = 15;
          final double boxWidth = constraints.maxWidth / gridCount;
          context.read<BoardCubit>().setBoxWidth(boxWidth);

          return AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                BaseGrid(boxWidth: boxWidth),
                HomeArea(
                  homeColor: const Color(0xFFD93830),
                  boxWidth: boxWidth,
                  top: 0,
                  left: 0,
                ),
                HomeArea(
                  homeColor: const Color(0xFF479D52),
                  boxWidth: boxWidth,
                  right: 0,
                  top: 0,
                ),
                HomeArea(
                  homeColor: Colors.blue,
                  boxWidth: boxWidth,
                  left: 0,
                  bottom: 0,
                ),
                HomeArea(
                  homeColor: const Color.fromARGB(255, 255, 216, 21),
                  boxWidth: boxWidth,
                  right: 0,
                  bottom: 0,
                ),
                WinArea(boxWidth: boxWidth),
              ],
            ),
          );
        }),
      ),
    ));
  }
}
