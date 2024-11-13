part of 'board_bloc.dart';

sealed class BoardEvent {}

final class RolledDice extends BoardEvent {
  RolledDice(this.colorBy);
  final OwnerColor colorBy;
}

final class SelectedPiece extends BoardEvent {
  SelectedPiece(this.piece);
  final Piece piece;
}
