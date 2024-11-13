import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ludo_flutter/src/features/board/bloc/game_state_cubit.dart';
import 'package:ludo_flutter/src/features/board/bloc/owner_color.dart';
import 'package:ludo_flutter/src/features/dice/rollable_dice.dart';
import 'bloc/board_cubit.dart';
import 'view/game_board.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final boxWidth = context.watch<BoxWidthCubit>().state;
    final state = context.watch<GameStateCubit>().state;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                state.turn == OwnerColor.green
                    ? const RollableDice(
                        playerColor: OwnerColor.green,
                      )
                    : SizedBox(
                        height: (2 * boxWidth),
                      ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: LayoutBuilder(builder: (context, constraints) {
                        final width =
                            constraints.maxHeight < constraints.maxWidth
                                ? constraints.maxHeight
                                : constraints.maxWidth;
                        const int gridCount = 15;
                        final double boxWidth = (width / gridCount);
                        context.read<BoxWidthCubit>().setBoxWidth(boxWidth);
                        return GameBoard(
                          boxWidth: boxWidth,
                        );
                      }),
                    ),
                  ),
                ),
                state.turn == OwnerColor.blue
                    ? const RollableDice(
                        playerColor: OwnerColor.blue,
                      )
                    : SizedBox(
                        height: (2 * boxWidth),
                      ),
              ],
            ),
          ),
        ));
  }
}
