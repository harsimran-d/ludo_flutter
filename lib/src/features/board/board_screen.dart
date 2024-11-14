import 'package:flutter/material.dart';

import 'package:ludo_flutter/src/features/board/bloc/owner_color.dart';
import 'package:ludo_flutter/src/features/dice/rollable_dice.dart';

import 'view/game_board.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxHeight < constraints.maxWidth
                  ? constraints.maxHeight
                  : constraints.maxWidth;
              const int gridCount = 15;
              final double boxWidth = (width / gridCount) * 0.75;

              return Column(
                children: [
                  RollableDice(
                    playerColor: OwnerColor.green,
                    boxWidth: boxWidth,
                  ),
                  Flexible(
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LayoutBuilder(builder: (context, constraints) {
                            final width =
                                constraints.maxHeight < constraints.maxWidth
                                    ? constraints.maxHeight
                                    : constraints.maxWidth;
                            const int gridCount = 15;
                            final double boxWidth = (width / gridCount);
                            return GameBoard(
                              boxWidth: boxWidth,
                            );
                          }),
                        )),
                  ),
                  RollableDice(
                    playerColor: OwnerColor.blue,
                    boxWidth: boxWidth,
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
