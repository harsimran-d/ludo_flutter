import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ludo_flutter/src/features/board/offsets/move_offsets.dart';
import 'package:ludo_flutter/src/features/board/bloc/piece.dart';

import 'owner_color.dart';
import 'player.dart';

part 'board_state.dart';
part 'board_event.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc()
      : super(
          BoardState(
            dice: 1,
            players: [
              Player(
                myColor: OwnerColor.green,
              ),
              Player(
                myColor: OwnerColor.blue,
              ),
            ],
            turn: Random().nextBool() ? OwnerColor.blue : OwnerColor.green,
            piecesGrid: List.generate(
              15,
              (_) => List.generate(15, (_) => []),
            ),
            isAnimatingPieces: false,
            hasTakenOneTurn: false,
          ),
        );

  Future<void> selectPieceToMove(Piece piece) async {
    print('piece was selected');
    if (piece.position == -1) {
      piece.position = 0;
      piece.location = MoveOffsets.getLocation(piece);
      state.piecesGrid[piece.location.$1][piece.location.$2].add(piece);

      state.players
          .firstWhere((player) => player.myColor == piece.owner)
          .pieces
          .forEach((piece) => piece.isSelectable = false);
    } else {
      if (piece.position < 56) {
        state.players
            .firstWhere((player) => player.myColor == piece.owner)
            .pieces
            .forEach((piece) => piece.isSelectable = false);

        await movePieceStepByStep(piece, state.dice);
      }
    }
    if (state.dice == 6) {
      Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(state.copyWith(hasTakenOneTurn: false)));
      return;
    }
    flipTurn(piece.owner);
  }

  void rollDice(OwnerColor color) {
    if (state.hasTakenOneTurn) {
      print('you have already taken turn');
      return;
    }
    state.hasTakenOneTurn = true;
    if (color != state.turn) {
      return;
    }
    if (state.isSelectingPieces) {
      return;
    }
    if (state.isAnimatingPieces) {
      return;
    }

    state.rollDice();
    final dice = state.dice;
    List<Piece> selectablePieces = state.players
        .singleWhere((player) => player.myColor == color)
        .pieces
        .where((piece) {
          if ((dice == 6) && (piece.position + dice) <= 56) {
            return true;
          } else {
            if ((piece.position != -1) && (piece.position + dice) <= 56) {
              return true;
            }
            return false;
          }
        })
        .map(
          (piece) => piece..isSelectable = true,
        )
        .toList();

    if (selectablePieces.isEmpty && !state.isSelectingPieces) {
      flipTurn(color);
      return;
    } else if (selectablePieces.length == 1) {
      selectPieceToMove(selectablePieces[0]);
    } else {
      Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(state.copyWith(dice: dice)));
      return;
    }
  }

  void flipTurn(OwnerColor color) {
    if (state.isAnimatingPieces || state.isSelectingPieces) {
      return;
    }
    final newTurn =
        color == OwnerColor.blue ? OwnerColor.green : OwnerColor.blue;
    final newState = state.copyWith(
      dice: state.dice,
      players: state.players,
      turn: newTurn,
      hasTakenOneTurn: false,
    );
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => emit(newState));
    return;
  }

  Future<void> movePieceStepByStep(Piece piece, int steps) async {
    for (int i = 0; i < steps; i++) {
      final isLastStep = i == steps - 1;
      await Future.delayed(const Duration(milliseconds: 250));
      var oldLocation = piece.location;
      state.piecesGrid[oldLocation.$1][oldLocation.$2].remove(piece);
      piece.position++;
      piece.location = MoveOffsets.getLocation(piece);
      if (isLastStep) {
        if (state.piecesGrid[piece.location.$1][piece.location.$2].isEmpty ||
            _isSafeSquare(piece.location)) {
          state.piecesGrid[piece.location.$1][piece.location.$2].add(piece);
          return emit(state.copyWith(isAnimatingPieces: false));
        } else {
          state.piecesGrid[piece.location.$1][piece.location.$2]
              .removeWhere((p) {
            if (p.owner != piece.owner) {
              p.position = -1;
              return true;
            }
            return false;
          });
          state.piecesGrid[piece.location.$1][piece.location.$2].add(piece);
          return emit(state.copyWith(isAnimatingPieces: false));
        }
      }
      state.piecesGrid[piece.location.$1][piece.location.$2].add(piece);

      emit(state.copyWith(isAnimatingPieces: true));
    }
  }

  bool _isSafeSquare((int, int) location) {
    const List<(int, int)> starSquares = [
      (2, 8),
      (6, 2),
      (8, 12),
      (12, 6),
    ];
    const List<(int, int)> colorStartSquares = [
      (1, 6),
      (6, 13),
      (8, 1),
      (13, 8)
    ];
    const List<(int, int)> safeSpaces = [...starSquares, ...colorStartSquares];
    return safeSpaces.contains(location);
  }
}
