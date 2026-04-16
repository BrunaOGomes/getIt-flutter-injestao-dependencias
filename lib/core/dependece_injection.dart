//aqui vamos centrsalizar a criação das dependências, ou seja, onde vamos registrar as dependências que serão usadas em toda a aplicação
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injestao_dependencias/core/http_client.dart';
import 'package:injestao_dependencias/data/mission_remote_service.dart';
import 'package:injestao_dependencias/data/misson_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  getIt.registerSingleton<CustomHttpClient>(CustomHttpClient());
  getIt.registerLazySingleton<MissionRemoteService>(
    () => MissionRemoteService(getIt()),
  );
  getIt.registerLazySingleton<MissionRepository>(
    () => MissionRepositoryImpl(getIt()),
  );
  // Aqui você pode registrar suas dependências
  // Exemplo:
  // getIt.registerLazySingleton<SomeService>(() => SomeServiceImpl());
}
