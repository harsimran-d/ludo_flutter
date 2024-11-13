import 'package:flutter_bloc/flutter_bloc.dart';

class BoxWidthCubit extends Cubit<double> {
  BoxWidthCubit() : super(0.0);

  void setBoxWidth(double boxWidth) {
    emit(boxWidth);
  }
}
