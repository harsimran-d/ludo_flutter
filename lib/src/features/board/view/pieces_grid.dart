import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/game_state.dart';
import '../state/game_state_cubit.dart';
import '../state/piece.dart';
import 'piece_widget.dart';

class PiecesGrid extends StatelessWidget {
  const PiecesGrid({
    super.key,
    required this.boxWidth,
  });

  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameStateCubit>().state;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 15,
      ),
      itemBuilder: (context, index) {
        return SizedBox(
          width: boxWidth,
          height: boxWidth,
          child: Center(child: _getChild(index, gameState)),
        );
      },
      itemCount: 15 * 15,
    );
  }

  Widget? _getChild(int index, GameState gameState) {
    final pieces = gameState.piecesGrid[index % 15][index ~/ 15];
    if (pieces.isEmpty) return null;
    if (pieces.length == 1) {
      return PieceWidget(piece: pieces[0]);
    } else {
      return Center(
          child: StackedRow(
        pieces: pieces,
        boxWidth: boxWidth,
      ));
    }
  }
}

class StackedRow extends StatelessWidget {
  const StackedRow({
    super.key,
    required this.pieces,
    required this.boxWidth,
  });

  final List<Piece> pieces;
  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: _getPositionedWidgets(),
    );
  }

  List<Widget> _getPositionedWidgets() {
    final totalWidth = (pieces.length - 1) * boxWidth / 4;
    final startOffset = (-totalWidth / 2) + 10;

    return List<Widget>.generate(pieces.length, (index) {
      final piece = pieces[index];
      return Positioned(
        left: startOffset + index * (boxWidth / 4),
        child: PieceWidget(
          piece: piece,
          updatedSize: 0.7,
        ),
      );
    });
  }
}
