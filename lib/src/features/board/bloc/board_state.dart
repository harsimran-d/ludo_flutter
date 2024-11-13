part of 'board_bloc.dart';

final class BoardState extends Equatable {
  const BoardState({
    required this.dice,
    required this.turn,
    required this.players,
    required this.piecesGrid,
  });

  final int dice;
  final OwnerColor turn;
  final List<Player> players;
  final List<List<List<Piece>>> piecesGrid;

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
  List<Object> get props => [turn, players, piecesGrid, isSelectingPieces];

  BoardState copyWith({
    int? dice,
    List<Player>? players,
    OwnerColor? turn,
    List<List<List<Piece>>>? piecesGrid,
  }) {
    return BoardState(
      dice: dice ?? this.dice,
      players: players ?? this.players,
      turn: turn ?? this.turn,
      piecesGrid: piecesGrid ?? this.piecesGrid,
    );
  }
}

final class AnimatingPieces extends BoardState {
  const AnimatingPieces(
      {required super.dice,
      required super.turn,
      required super.players,
      required super.piecesGrid});
}
