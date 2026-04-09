import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/mission_list_screen.dart';
import 'presentation/mission_view_model.dart';
//onde o app comeca
Future<void> main() async {
  //ele é tipo uma injestao previa ,injetando tudo que o add precisa para nao quebrar ,famoso prepara o terreno
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDependencies();
  //inicio flutter reendenização
  runApp(
    //provider == injecao de estado
    MultiProvider(
      //Injeta o MissionViewModel no app inteiro.
      providers: [
        ChangeNotifierProvider(
          //cria o viewmodel
          //loadMission = Cria o ViewModel ej á carrega as missões automaticamente
          create: (_) => MissionViewModel(),
        ),
      ],
      //define o app principal
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA - Missões',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MissionListScreen(),
    );
  }
}
