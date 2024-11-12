import 'dart:ui';

import '../state/owner_color.dart';
import '../state/piece.dart';

class MoveOffsets {
  static (int x, int y) getLocation(Piece piece) {
    switch (piece.owner) {
      case OwnerColor.red:
        return redBoxCoords[piece.position];

      case OwnerColor.green:
        return greenBoxCoords[piece.position];

      case OwnerColor.blue:
        return blueBoxCoords[piece.position];

      case OwnerColor.yellow:
        return yellowBoxCoords[piece.position];

      default:
        throw Exception('could no');
    }
  }

  static Offset getBoardOffset(Piece piece, double boxWidth) {
    switch (piece.owner) {
      case OwnerColor.red:
        final (x, y) = redBoxCoords[piece.position];
        return Offset(x * boxWidth, y * boxWidth);
      case OwnerColor.green:
        final (x, y) = greenBoxCoords[piece.position];
        return Offset(x * boxWidth, y * boxWidth);
      case OwnerColor.blue:
        final (x, y) = blueBoxCoords[piece.position];
        return Offset(x * boxWidth, y * boxWidth);
      case OwnerColor.yellow:
        final (x, y) = yellowBoxCoords[piece.position];
        return Offset(x * boxWidth, y * boxWidth);
      default:
        throw Exception('could no');
    }
  }

  static Offset getHomeOffset(Piece piece, double boxWidth) {
    switch (piece.owner) {
      case OwnerColor.red:
        switch (piece.id) {
          case 1:
            return Offset(boxWidth * 1.5, boxWidth * 1.5);
          case 2:
            return Offset(boxWidth * 3.5, boxWidth * 1.5);
          case 3:
            return Offset(boxWidth * 1.5, 3.5 * boxWidth);
          case 4:
            return Offset(boxWidth * 3.5, 3.5 * boxWidth);
          default:
            throw Exception('something went wrong getting position for red');
        }

      case OwnerColor.green:
        switch (piece.id) {
          case 1:
            return Offset(boxWidth * 10.5, boxWidth * 1.5);
          case 2:
            return Offset(boxWidth * 12.5, boxWidth * 1.5);
          case 3:
            return Offset(boxWidth * 10.5, 3.5 * boxWidth);
          case 4:
            return Offset(boxWidth * 12.5, 3.5 * boxWidth);
          default:
            throw Exception('something went wrong getting position for red');
        }

      case OwnerColor.blue:
        switch (piece.id) {
          case 1:
            return Offset(boxWidth * 1.5, boxWidth * 10.5);
          case 2:
            return Offset(boxWidth * 3.5, boxWidth * 10.5);
          case 3:
            return Offset(boxWidth * 1.5, boxWidth * 12.5);
          case 4:
            return Offset(boxWidth * 3.5, boxWidth * 12.5);
          default:
            throw Exception('something went wrong getting position for red');
        }
      case OwnerColor.yellow:
        switch (piece.id) {
          case 1:
            return Offset(boxWidth * 10.5, boxWidth * 10.5);
          case 2:
            return Offset(boxWidth * 12.5, boxWidth * 10.5);
          case 3:
            return Offset(boxWidth * 10.5, boxWidth * 12.5);
          case 4:
            return Offset(boxWidth * 12.5, boxWidth * 12.5);
          default:
            throw Exception('something went wrong getting position for red');
        }

      default:
        throw Exception('something went wrong');
    }
  }
}

const List<(int x, int y)> redBoxCoords = [
  (1, 6),
  (2, 6),
  (3, 6),
  (4, 6),
  (5, 6),
  (6, 5),
  (6, 4),
  (6, 3),
  (6, 2),
  (6, 1),
  (6, 0),
  (7, 0),
  (8, 0),
  (8, 1),
  (8, 2),
  (8, 3),
  (8, 4),
  (8, 5),
  (9, 6),
  (10, 6),
  (11, 6),
  (12, 6),
  (13, 6),
  (14, 6),
  (14, 7),
  (14, 8),
  (13, 8),
  (12, 8),
  (11, 8),
  (10, 8),
  (9, 8),
  (8, 9),
  (8, 10),
  (8, 11),
  (8, 12),
  (8, 13),
  (8, 14),
  (7, 14),
  (6, 14),
  (6, 13),
  (6, 12),
  (6, 11),
  (6, 10),
  (6, 9),
  (5, 8),
  (4, 8),
  (3, 8),
  (2, 8),
  (1, 8),
  (0, 8),
  (0, 7),
  (1, 7),
  (2, 7),
  (3, 7),
  (4, 7),
  (5, 7),
  (6, 7),
];
const List<(int x, int y)> greenBoxCoords = [
  (8, 1),
  (8, 2),
  (8, 3),
  (8, 4),
  (8, 5),
  (9, 6),
  (10, 6),
  (11, 6),
  (12, 6),
  (13, 6),
  (14, 6),
  (14, 7),
  (14, 8),
  (13, 8),
  (12, 8),
  (11, 8),
  (10, 8),
  (9, 8),
  (8, 9),
  (8, 10),
  (8, 11),
  (8, 12),
  (8, 13),
  (8, 14),
  (7, 14),
  (6, 14),
  (6, 13),
  (6, 12),
  (6, 11),
  (6, 10),
  (6, 9),
  (5, 8),
  (4, 8),
  (3, 8),
  (2, 8),
  (1, 8),
  (0, 8),
  (0, 7),
  (0, 6),
  (1, 6),
  (2, 6),
  (3, 6),
  (4, 6),
  (5, 6),
  (6, 5),
  (6, 4),
  (6, 3),
  (6, 2),
  (6, 1),
  (6, 0),
  (7, 0),
  (7, 1),
  (7, 2),
  (7, 3),
  (7, 4),
  (7, 5),
  (7, 6)
];
const List<(int x, int y)> blueBoxCoords = [
  (6, 13),
  (6, 12),
  (6, 11),
  (6, 10),
  (6, 9),
  (5, 8),
  (4, 8),
  (3, 8),
  (2, 8),
  (1, 8),
  (0, 8),
  (0, 7),
  (0, 6),
  (1, 6),
  (2, 6),
  (3, 6),
  (4, 6),
  (5, 6),
  (6, 5),
  (6, 4),
  (6, 3),
  (6, 2),
  (6, 1),
  (6, 0),
  (7, 0),
  (8, 0),
  (8, 1),
  (8, 2),
  (8, 3),
  (8, 4),
  (8, 5),
  (9, 6),
  (10, 6),
  (11, 6),
  (12, 6),
  (13, 6),
  (14, 6),
  (14, 7),
  (14, 8),
  (13, 8),
  (12, 8),
  (11, 8),
  (10, 8),
  (9, 8),
  (8, 9),
  (8, 10),
  (8, 11),
  (8, 12),
  (8, 13),
  (8, 14),
  (7, 14),
  (7, 13),
  (7, 12),
  (7, 11),
  (7, 10),
  (7, 9),
  (7, 8),
];
const List<(int x, int y)> yellowBoxCoords = [
  (13, 8),
  (12, 8),
  (11, 8),
  (10, 8),
  (9, 8),
  (8, 9),
  (8, 10),
  (8, 11),
  (8, 12),
  (8, 13),
  (8, 14),
  (7, 14),
  (6, 14),
  (6, 13),
  (6, 12),
  (6, 11),
  (6, 10),
  (6, 9),
  (5, 8),
  (4, 8),
  (3, 8),
  (2, 8),
  (1, 8),
  (0, 8),
  (0, 7),
  (0, 6),
  (1, 6),
  (2, 6),
  (3, 6),
  (4, 6),
  (5, 6),
  (6, 5),
  (6, 4),
  (6, 3),
  (6, 2),
  (6, 1),
  (6, 0),
  (7, 0),
  (8, 0),
  (8, 1),
  (8, 2),
  (8, 3),
  (8, 4),
  (8, 5),
  (9, 6),
  (10, 6),
  (11, 6),
  (12, 6),
  (13, 6),
  (14, 6),
  (14, 7),
  (13, 7),
  (12, 7),
  (11, 7),
  (10, 7),
  (9, 7),
  (8, 7),
];
