part of 'board_bloc.dart';

enum BoardStatus {
  readyForRoll,
  animatingDice,
  selectingPieces,
  animatingPiecesOn,
  animatingPiecesOff,
  gameOver
}

final class BoardState extends Equatable {
  const BoardState({
    required this.status,
    required this.dice,
    required this.turn,
    required this.players,
    required this.piecesGrid,
    this.winner,
  });

  final BoardStatus status;
  final int dice;
  final OwnerColor turn;
  final List<Player> players;
  final List<List<List<Piece>>> piecesGrid;
  final OwnerColor? winner;
  bool get isSelectingPieces {
    bool selectablePieces = false;
    for (Player player in players) {
      selectablePieces = player.pieces.any((piece) => piece.isSelectable);
    }
    return selectablePieces;
  }

  int rollDice() {
    final bias = Random().nextInt(4);
    if (bias == 0) {
      return 6;
    } else {
      return Random().nextInt(5) + 1;
    }
  }

  @override
  List<Object> get props =>
      [status, dice, turn, players, piecesGrid, isSelectingPieces];

  BoardState copyWith({
    BoardStatus? status,
    int? dice,
    List<Player>? players,
    OwnerColor? turn,
    List<List<List<Piece>>>? piecesGrid,
    OwnerColor? winner,
  }) {
    return BoardState(
      status: status ?? this.status,
      dice: dice ?? this.dice,
      players: players ?? this.players,
      turn: turn ?? this.turn,
      piecesGrid: piecesGrid ?? this.piecesGrid,
      winner: winner ?? this.winner,
    );
  }
}
