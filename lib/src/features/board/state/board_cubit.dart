import 'package:flutter_bloc/flutter_bloc.dart';

class BoardCubit extends Cubit<double> {
  BoardCubit() : super(0.0);

  void setBoxWidth(double boxWidth) {
    emit(boxWidth);
  }
}
