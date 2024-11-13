import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ludo_flutter/src/features/board/bloc/board_bloc.dart';
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
  Timer? _debouncer;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.read<BoardBloc>().rollDice(widget.playerColor);
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
    _debouncer?.cancel();
    super.dispose();
  }

  void rollDice() {
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 100), () {
      print('so many ');
      final gameState = context.read<BoardBloc>().state;
      print('is animating pieces ${gameState.isAnimatingPieces}');
      if (gameState.isSelectingPieces || gameState.isAnimatingPieces) {
        return;
      }

      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final boxWidth = context.watch<BoxWidthCubit>().state;
    return GestureDetector(
      onTap: rollDice,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          final diceFace = context.read<BoardBloc>().state.dice;
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
    );
  }
}
