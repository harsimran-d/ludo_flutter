import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_flutter/src/features/board/bloc/board_cubit.dart';
import 'package:ludo_flutter/src/features/board/bloc/board_bloc.dart';
import 'package:ludo_flutter/src/features/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BoxWidthCubit()),
        BlocProvider(create: (context) => BoardBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
