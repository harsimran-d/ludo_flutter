import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_flutter/src/features/board/state/board_cubit.dart';
import 'package:ludo_flutter/src/features/board/board_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => BoardCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BoardScreen(),
      ),
    );
  }
}
