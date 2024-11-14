import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/board_bloc.dart';
import '../bloc/piece.dart';
import 'piece_widget.dart';

class PiecesGrid extends StatelessWidget {
  const PiecesGrid({
    super.key,
    required this.boxWidth,
  });

  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardBloc, BoardState>(
      listenWhen: (previous, current) {
        return current.status == BoardStatus.gameOver;
      },
      listener: (context, state) {
        if (state.status == BoardStatus.gameOver) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentTextStyle:
                      TextStyle(fontSize: 32, color: state.winner!.myColor),
                  title: const Text(
                    "Game Over",
                    textAlign: TextAlign.center,
                  ),
                  content: Text('${state.winner!.title} won'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<BoardBloc>().add(RestartGame());
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: const Text(
                          'Play Again',
                          style: TextStyle(fontSize: 26),
                        ))
                  ],
                );
              });
        }
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        return GridView.builder(
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 15,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              width: boxWidth,
              height: boxWidth,
              child: Center(child: _getChild(index, state)),
            );
          },
          itemCount: 15 * 15,
        );
      },
    );
  }

  Widget? _getChild(int index, BoardState gameState) {
    final pieces = gameState.piecesGrid[index % 15][index ~/ 15];
    if (pieces.isEmpty) return null;
    if (pieces.length == 1) {
      return PieceWidget(
        piece: pieces[0],
        boxWidth: boxWidth,
      );
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
          boxWidth: boxWidth,
        ),
      );
    });
  }
}
