import 'dart:math';

import 'package:ludo_flutter/src/features/board/state/owner_color.dart';

import 'player.dart';

class GameState {
  GameState(
    int dice, {
    required this.players,
    required this.turn,
  }) : _dice = dice;
  final List<Player> players;
  final OwnerColor turn;
  int _dice;

  bool get isSelectingPieces {
    bool selectablePieces = false;
    for (Player player in players) {
      selectablePieces = player.pieces.any((piece) => piece.isSelectable);
    }
    return selectablePieces;
  }

  int get dice => _dice;

  GameState copyWith({
    int? dice,
    List<Player>? players,
    OwnerColor? turn,
  }) {
    return GameState(
      dice ?? this.dice,
      players: players ?? this.players,
      turn: turn ?? this.turn,
    );
  }

  void rollDice() {
    if (isSelectingPieces) {
      return;
    }
    final bias = Random().nextInt(4);
    if (bias == 0) {
      _dice = 6;
    } else {
      _dice = Random().nextInt(5) + 1;
    }
  }
}
