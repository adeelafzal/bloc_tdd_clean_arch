import 'package:bloc_tdd_clean_arch/core/services/injection_container.dart';
import 'package:bloc_tdd_clean_arch/features/articles/presentation/bloc/article_bloc.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ArticleBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
