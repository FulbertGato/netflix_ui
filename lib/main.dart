import 'package:flutter/material.dart';
import 'package:netflix_ui/ui/screens/loading_screen.dart';

import 'package:provider/provider.dart';
import 'repositories/data_repository.dart';
import 'ui/screens/tab_screen.dart';

void main() {
 runApp(
    ChangeNotifierProvider(
      create: (context) => DataRepository(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',
      //darkTheme: ThemeData.dark(),
      theme: ThemeData( ),
      home: const LoadingScreen(),
    );
  }
}

