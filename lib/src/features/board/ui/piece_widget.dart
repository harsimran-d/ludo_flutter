import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ludo_flutter/src/features/board/state/board_cubit.dart';
import 'package:ludo_flutter/src/features/board/state/game_state_cubit.dart';
import 'package:ludo_flutter/src/features/board/state/piece.dart';

class PieceWidget extends StatelessWidget {
  const PieceWidget({
    super.key,
    required this.piece,
    this.updatedSize = 1.0,
  });
  final Piece piece;
  final double updatedSize;

  @override
  Widget build(BuildContext context) {
    final size = context.read<BoxWidthCubit>().state * updatedSize;
    return Transform.scale(
      scale: 1.3,
      child: Transform.translate(
        offset: const Offset(0, -25),
        child: GestureDetector(
          onTap: piece.isSelectable
              ? () {
                  context.read<GameStateCubit>().selectPieceToMove(piece);
                }
              : null,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              if (piece.isSelectable)
                const Positioned(
                  bottom: -10,
                  child: CircularProgressIndicator(),
                ),
              SvgPicture.asset(
                width: size,
                height: size,
                'assets/pin_background.svg',
              ),
              SvgPicture.asset(
                width: size,
                height: size,
                colorFilter: ColorFilter.mode(
                  piece.owner.myColor,
                  BlendMode.srcIn,
                ),
                'assets/pin_colored.svg',
              ),
              SvgPicture.asset(
                width: size,
                height: size,
                'assets/pin_circle.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
