import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_flutter/src/features/board/state/piece.dart';

import 'game_state.dart';
import 'owner_color.dart';
import 'player.dart';

class GameStateCubit extends Cubit<GameState> {
  GameStateCubit()
      : super(
          GameState(
            1,
            players: [
              Player(
                myColor: OwnerColor.green,
              ),
              Player(
                myColor: OwnerColor.blue,
              ),
            ],
            turn: Random().nextBool() ? OwnerColor.blue : OwnerColor.green,
          ),
        );

  void selectPieceToMove(Piece piece) {
    print('user of ${piece.owner} selected ${piece.id}');
    if (piece.position == -1) {
      piece.position = 0;
      state.players
          .firstWhere((player) => player.myColor == piece.owner)
          .pieces
          .forEach((piece) => piece.isSelectable = false);
    } else {
      if (piece.position < 56) {
        piece.position += state.dice;
        state.players
            .firstWhere((player) => player.myColor == piece.owner)
            .pieces
            .forEach((piece) => piece.isSelectable = false);
      }
    }
    final newTurn =
        piece.owner == OwnerColor.blue ? OwnerColor.green : OwnerColor.blue;
    final newState =
        GameState(state.dice, players: state.players, turn: newTurn);
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => emit(newState));
  }

  void rollDice(OwnerColor color) {
    state.rollDice();
    final dice = state.dice;
    if (color != state.turn) {
      return;
    }
    bool noPieceOnBoard = !state.players
        .singleWhere((player) => player.myColor == color)
        .pieces
        .any((piece) => piece.position != -1);

    if (dice != 6 && noPieceOnBoard) {
      final newTurn =
          color == OwnerColor.blue ? OwnerColor.green : OwnerColor.blue;
      final newState =
          GameState(state.dice, players: state.players, turn: newTurn);
      Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(newState));
    } else if (dice == 6 && noPieceOnBoard) {
      state.players
          .singleWhere((player) => player.myColor == color)
          .pieces
          .forEach((piece) => piece.isSelectable = true);

      Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(state.copyWithRandomId()));
    } else if (!noPieceOnBoard) {
      state.players
          .firstWhere((player) => player.myColor == color)
          .pieces
          .forEach((piece) {
        if (piece.position != -1 && piece.position != 56) {
          piece.isSelectable = true;
          Future.delayed(const Duration(milliseconds: 500))
              .then((_) => emit(state.copyWithRandomId()));
        }
      });
    }
  }
}
