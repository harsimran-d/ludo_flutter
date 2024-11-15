import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_flutter/src/features/board/offsets/move_offsets.dart';

import '../bloc/board_bloc.dart';
import 'base_grid.dart';
import 'home_area.dart';

import 'piece_widget.dart';
import 'pieces_grid.dart';

import 'win_area.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    required this.boxWidth,
    super.key,
  });
  final double boxWidth;
  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<BoardBloc>().state;
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        height: 15 * boxWidth,
        width: 15 * boxWidth,
        child: Stack(
          clipBehavior: Clip.none,
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
            PiecesGrid(
              boxWidth: boxWidth,
            ),
            ...gameState.players.expand<Widget>((player) {
              return List.generate(4, (i) {
                final pieces = player.pieces;
                final offset = MoveOffsets.getHomeOffset(pieces[i], boxWidth);

                if (pieces[i].position != -1) {
                  return const SizedBox.shrink();
                }
                return Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: SizedBox(
                    height: boxWidth,
                    width: boxWidth,
                    child: PieceWidget(
                      piece: pieces[i],
                      boxWidth: boxWidth,
                    ),
                  ),
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}
