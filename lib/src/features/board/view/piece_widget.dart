import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ludo_flutter/src/features/board/bloc/board_cubit.dart';
import 'package:ludo_flutter/src/features/board/bloc/game_state_cubit.dart';
import 'package:ludo_flutter/src/features/board/bloc/piece.dart';

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
    final size = context.watch<BoxWidthCubit>().state * updatedSize;
    return Transform.scale(
      scale: 1.3,
      child: Transform.translate(
        offset: Offset(0, -(size / 2)),
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
                Positioned(
                  bottom: -10,
                  child: SizedBox(
                      width: size * .7,
                      height: size * .7,
                      child: const CircularProgressIndicator()),
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
