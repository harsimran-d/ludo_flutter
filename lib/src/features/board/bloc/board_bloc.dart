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
            piecesGrid: List.generate(15, (_) => List.generate(15, (_) => [])),
          ),
        ) {
    on<RolledDice>(_diceRolled);
    on<SelectedPiece>(_selectPieceToMove);
  }

  Future<void> _selectPieceToMove(
      SelectedPiece event, Emitter<BoardState> emit) async {
    final piece = event.piece;
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
          .then((_) => emit(state.copyWith()));
      return;
    }
    flipTurn(piece.owner, emit);
  }

  void _diceRolled(RolledDice event, Emitter<BoardState> emit) async {
    if (state is AnimatingPieces) {
      return;
    }
    final dice = state.rollDice();
    List<Piece> selectablePieces = state.players
        .singleWhere((player) => player.myColor == event.colorBy)
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
      flipTurn(event.colorBy, emit);
      return;
    } else if (selectablePieces.length == 1) {
      _selectPieceToMove(SelectedPiece(selectablePieces[0]), emit);
    } else {
      await Future.delayed(const Duration(milliseconds: 500))
          .then((_) => emit(state.copyWith(dice: dice)));
      return;
    }
  }

  void flipTurn(OwnerColor color, Emitter<BoardState> emit) {
    final newTurn =
        color == OwnerColor.blue ? OwnerColor.green : OwnerColor.blue;
    final newState = state.copyWith(
      dice: state.dice,
      players: state.players,
      turn: newTurn,
      piecesGrid: state.piecesGrid,
    );
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => emit(newState));
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
          return emit(state.copyWith());
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
          return emit(state.copyWith());
        }
      }
      state.piecesGrid[piece.location.$1][piece.location.$2].add(piece);

      emit(state.copyWith());
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
