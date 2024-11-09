import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ludo_flutter/src/features/board/state/game_state_cubit.dart';
import 'package:ludo_flutter/src/features/board/state/owner_color.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          context.read<GameStateCubit>().rollDice(widget.playerColor);
        });

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
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: rollDice,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          final diceFace = context.read<GameStateCubit>().state.dice;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(_animation.value),
            child: Container(
              decoration: BoxDecoration(
                color: widget.playerColor.myColor.withAlpha(100),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    diceFace.toString(),
                    style: const TextStyle(
                      fontSize: 48,
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
