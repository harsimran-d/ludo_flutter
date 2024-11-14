import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ludo_flutter/src/features/board/bloc/board_bloc.dart';
import 'package:ludo_flutter/src/features/board/bloc/owner_color.dart';

class RollableDice extends StatefulWidget {
  const RollableDice({
    super.key,
    required this.playerColor,
    required this.boxWidth,
  });
  final OwnerColor playerColor;
  final double boxWidth;
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
    context.read<BoardBloc>().add(RolledDice(widget.playerColor));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardBloc, BoardState>(
      listener: (context, state) {
        if (state.status == BoardStatus.animatingDice) {
          _controller.forward();
        }
      },
      buildWhen: (previous, current) {
        return (previous != current);
      },
      builder: (BuildContext context, BoardState state) {
        return state.turn == widget.playerColor
            ? GestureDetector(
                key: Key(widget.playerColor.toString()),
                onTap: state.turn == widget.playerColor ? rollDice : null,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    return Center(
                      child: SizedBox(
                        height: 2.5 * widget.boxWidth,
                        width: 2.5 * widget.boxWidth,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.002)
                            ..rotateY(_animation.value),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.playerColor.myColor.withAlpha(100),
                              borderRadius:
                                  BorderRadius.circular(widget.boxWidth * 0.3),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.dice.toString(),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : SizedBox(
                height: (2.5 * widget.boxWidth),
              );
      },
    );
  }
}
