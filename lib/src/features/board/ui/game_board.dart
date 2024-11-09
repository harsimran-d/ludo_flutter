import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../offsets/move_offsets.dart';
import '../state/board_cubit.dart';
import '../state/game_state.dart';
import '../state/game_state_cubit.dart';
import '../state/piece.dart';
import 'base_grid.dart';
import 'home_area.dart';
import 'piece_widget.dart';
import 'positioned_piece.dart';
import 'win_area.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameStateCubit>().state;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxHeight < constraints.maxWidth
          ? constraints.maxHeight
          : constraints.maxWidth;
      const int gridCount = 15;
      final double boxWidth = width / gridCount;
      context.read<BoxWidthCubit>().setBoxWidth(boxWidth);

      return AspectRatio(
        aspectRatio: 1,
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
            ..._getPositionedPieces(gameState, boxWidth),
          ],
        ),
      );
    });
  }

  List<Widget> _getPositionedPieces(GameState gameState, double boxWidth) {
    final List<Piece> piecesList = [];

    for (final player in gameState.players) {
      for (final piece in player.pieces) {
        piecesList.add(piece);
      }
    }
    return piecesList.map((piece) {
      final position = _getPositionOnBoard(piece, boxWidth);
      return PositionedPiece(
          position: position,
          piece: PieceWidget(
            piece: piece,
          ));
    }).toList();
  }
}

Offset _getPositionOnBoard(Piece piece, double boxWidth) {
  if (piece.position == -1) {
    return MoveOffsets.getHomeOffset(piece, boxWidth);
  } else {
    final gridOffset = MoveOffsets.getBoardOffset(piece, boxWidth);
    return Offset(gridOffset.dx, gridOffset.dy - (boxWidth / 2));
  }
}
