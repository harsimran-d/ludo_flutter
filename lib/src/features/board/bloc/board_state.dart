part of 'board_bloc.dart';

final class BoardState extends Equatable {
  BoardState({
    required this.dice,
    required this.players,
    required this.turn,
    required this.piecesGrid,
    required this.isAnimatingPieces,
    required this.hasTakenOneTurn,
  });

  final List<Player> players;
  final OwnerColor turn;
  int dice;
  bool isAnimatingPieces;
  bool hasTakenOneTurn;
  final List<List<List<Piece>>> piecesGrid;

  bool get isSelectingPieces {
    bool selectablePieces = false;
    for (Player player in players) {
      selectablePieces = player.pieces.any((piece) => piece.isSelectable);
    }
    return selectablePieces;
  }

  void rollDice() {
    if (isSelectingPieces) {
      return;
    }
    final bias = Random().nextInt(4);
    if (bias == 0) {
      dice = 6;
    } else {
      dice = Random().nextInt(5) + 1;
    }
  }

  @override
  List<Object> get props =>
      [dice, turn, players, piecesGrid, isSelectingPieces, hasTakenOneTurn];

  BoardState copyWith({
    int? dice,
    List<Player>? players,
    OwnerColor? turn,
    List<List<List<Piece>>>? piecesGrid,
    bool? isAnimatingPieces,
    bool? hasTakenOneTurn,
  }) {
    return BoardState(
      dice: dice ?? this.dice,
      players: players ?? this.players,
      turn: turn ?? this.turn,
      piecesGrid: piecesGrid ?? this.piecesGrid,
      isAnimatingPieces: isAnimatingPieces ?? this.isAnimatingPieces,
      hasTakenOneTurn: hasTakenOneTurn ?? this.hasTakenOneTurn,
    );
  }
}
