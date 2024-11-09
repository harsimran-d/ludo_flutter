import 'dart:math';

import 'package:ludo_flutter/src/features/board/state/owner_color.dart';

import 'player.dart';

class GameState {
  GameState(
    int dice, {
    required this.players,
    required this.turn,
  })  : _dice = dice,
        id = Random().nextInt(100000);
  final List<Player> players;
  OwnerColor turn;
  int _dice;
  int id;

  int get dice => _dice;

  GameState copyWithRandomId() {
    return GameState(dice, players: players, turn: turn);
  }

  void rollDice() {
    _dice = Random().nextInt(6) + 1;
    print('setting dice to new number $_dice');
  }
}
