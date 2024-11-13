import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_flutter/src/features/board/bloc/game_state.dart';

import 'package:ludo_flutter/src/features/board/bloc/game_state_cubit.dart';
import 'package:ludo_flutter/src/features/board/bloc/owner_color.dart';

import '../board/bloc/board_cubit.dart';

class RollableDice extends StatefulWidget {
  const RollableDice({
    super.key,
    required this.playerColor,
  });
  final OwnerColor playerColor;

  @override
  State<StatefulWidget> createState() => RollableDiceState();
}

class RollableDiceState extends State<RollableDice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _clickedForTurn = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.read<GameStateCubit>().rollDice(widget.playerColor);
        _controller.reset();
      }
    });

    _animation = Tween<double>(begin: 0, end: pi * 2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void rollDice() {
    if (_clickedForTurn) {
      return;
    }
    _clickedForTurn = true;
    final gameState = context.read<GameStateCubit>().state;
    if (gameState.isSelectingPieces) {
      return;
    }

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final boxWidth = context.watch<BoxWidthCubit>().state;
    return BlocListener<GameStateCubit, GameState>(
      listener: (context, state) {
        if ((state.turn == widget.playerColor) &&
            (!state.isSelectingPieces) &&
            (!state.piecesAreMoving)) {
          _clickedForTurn = false;
        }
      },
      child: GestureDetector(
        onTap: rollDice,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            final diceFace = context.read<GameStateCubit>().state.dice;
            return Center(
              child: SizedBox(
                height: 2 * boxWidth,
                width: 2 * boxWidth,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(_animation.value),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.playerColor.myColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(boxWidth * 0.3),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        diceFace.toString(),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
