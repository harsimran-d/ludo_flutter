import 'owner_color.dart';

class Piece {
  Piece({
    required this.owner,
    required this.id,
    required this.location,
    this.position = -1,
    this.isSafe = false,
    this.isSelectable = false,
  });
  int id;
  int position;
  (int, int) location;
  OwnerColor owner;
  bool isSafe;
  bool isSelectable;
}
