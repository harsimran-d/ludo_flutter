import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ludo_flutter/src/features/board/state/game_state_cubit.dart';
import 'package:ludo_flutter/src/features/board/state/owner_color.dart';
import 'package:ludo_flutter/src/features/dice/rollable_dice.dart';
import 'ui/game_board.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    : const SizedBox(
                        height: 104,
                      ),
                const SizedBox(
                  height: 30,
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GameBoard(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                state.turn == OwnerColor.blue
                    ? const RollableDice(
                        playerColor: OwnerColor.blue,
                      )
                    : const SizedBox(
                        height: 104,
                      ),
              ],
            ),
          ),
        ));
  }
}
