import 'package:flutter/material.dart';
import 'package:injestao_dependencias/core/dependece_injection.dart';
import 'package:provider/provider.dart';

import 'presentation/mission_list_screen.dart';
import 'presentation/mission_view_model.dart';

//onde o app comeca
Future<void> main() async {
  //ele é tipo uma injestao previa ,injetando tudo que o add precisa para nao quebrar ,famoso prepara o terreno
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  //inicio flutter reendenização
  runApp(
    //provider == injecao de estado
    MultiProvider(
      //Injeta o MissionViewModel no app inteiro.
      //provider -> gerenciador de estado simples e eficiente
      providers: [
        ChangeNotifierProvider(
          //cria o viewmodel
          //loadMission = Cria o ViewModel ej á carrega as missões automaticamente
          create: (_) => MissionViewModel(getIt()),
        ),
      ],
      //define o app principal
      child: const MyApp(),
    ),
  );
}

// Classe principal do app (sem estado - Stateless)
class MyApp extends StatelessWidget {
  // Construtor com suporte a chave (key) para controle do widget
  //Tudo é widget: botão, texto, tela inteira, ícone, layout…
  const MyApp({super.key});
  // Método obrigatório que constrói a interface
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título do aplicativo (usado pelo sistema)
      title: 'NASA - Missões',
      // Remove a faixa "debug" no canto da tela
      debugShowCheckedModeBanner: false,
      // Tema global do app
      theme: ThemeData(
        // Define o esquema de cores baseado em uma cor principal
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        // Ativa o Material Design 3
        useMaterial3: true,
      ),
      // Tela inicial do aplicativo
      home: const MissionListScreen(),
    );
  }
}
