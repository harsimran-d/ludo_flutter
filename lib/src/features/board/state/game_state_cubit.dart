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
    if (piece.position == -1) {
      piece.position = 0;
      state.players
          .firstWhere((player) => player.myColor == piece.owner)
          .pieces
          .forEach((piece) => piece.isSelectable = false);
      print('marked the pieces not selectable');
    } else {
      if (piece.position < 56) {
        piece.position += state.dice;
        state.players
            .firstWhere((player) => player.myColor == piece.owner)
            .pieces
            .forEach((piece) => piece.isSelectable = false);
      }
    }
    if (state.dice == 6) {
      print('this happend before emitting');
      Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(state.copyWithRandomId()));
      return;
    }
    final newTurn =
        piece.owner == OwnerColor.blue ? OwnerColor.green : OwnerColor.blue;
    final newState = GameState(
      state.dice,
      players: state.players,
      turn: newTurn,
    );
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => emit(newState));
    return;
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
      final newState = GameState(
        state.dice,
        players: state.players,
        turn: newTurn,
      );
      Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(newState));
      return;
    } else if (dice == 6) {
      state.players
          .singleWhere((player) => player.myColor == color)
          .pieces
          .forEach((piece) {
        if ((piece.position + state.dice) <= 56) {
          piece.isSelectable = true;
        }
      });

      Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(state.copyWithRandomId()));
      return;
    } else if (!noPieceOnBoard) {
      bool aPieceSelected = false;
      state.players
          .firstWhere((player) => player.myColor == color)
          .pieces
          .forEach((piece) {
        if (piece.position != -1 &&
            piece.position != 56 &&
            ((piece.position + state.dice) <= 56)) {
          piece.isSelectable = true;
          aPieceSelected = true;
        }
        // } else {
        //   final newTurn =
        //       color == OwnerColor.blue ? OwnerColor.green : OwnerColor.blue;
        //   final newState =
        //       GameState(state.dice, players: state.players, turn: newTurn);
        //   Future.delayed(const Duration(milliseconds: 500))
        //       .then((_) => emit(newState));
        // }
      });
      if (aPieceSelected) {
        Future.delayed(const Duration(milliseconds: 500))
            .then((_) => emit(state.copyWithRandomId()));
      } else {
        // swtich turn
        flipTurn(color);
      }
      return;
    }
    throw Exception('Dice roll never handled $state $dice');
  }

  void flipTurn(OwnerColor color) {
    final newTurn =
        color == OwnerColor.blue ? OwnerColor.green : OwnerColor.blue;
    final newState = GameState(
      state.dice,
      players: state.players,
      turn: newTurn,
    );
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => emit(newState));
    return;
  }
}
