import 'owner_color.dart';
import 'piece.dart';

class Player {
  Player({
    required this.myColor,
  }) : pieces = [
          Piece(id: 1, owner: myColor),
          Piece(id: 2, owner: myColor),
          Piece(id: 3, owner: myColor),
          Piece(id: 4, owner: myColor),
        ];
  final List<Piece> pieces;
  OwnerColor myColor;
}
