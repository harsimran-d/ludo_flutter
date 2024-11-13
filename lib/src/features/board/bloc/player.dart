import 'owner_color.dart';
import 'piece.dart';

class Player {
  Player({
    required this.myColor,
  }) : pieces = [
          Piece(id: 1, owner: myColor, location: (0, 0)),
          Piece(id: 2, owner: myColor, location: (0, 0)),
          Piece(id: 3, owner: myColor, location: (0, 0)),
          Piece(id: 4, owner: myColor, location: (0, 0)),
        ];
  final List<Piece> pieces;
  OwnerColor myColor;
}
