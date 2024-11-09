import 'package:flutter/material.dart';
import 'package:ludo_flutter/src/features/board/ui/piece_widget.dart';

class PositionedPiece extends StatelessWidget {
  const PositionedPiece({
    super.key,
    required this.position,
    required this.piece,
  });

  final Offset position;
  final PieceWidget piece;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: piece,
    );
  }
}
