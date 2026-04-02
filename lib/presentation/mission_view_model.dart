import 'package:flutter/foundation.dart';

import '../domain/mission_model.dart';

/// ViewModel responsável por gerenciar o estado da lista de missões.
class MissionViewModel extends ChangeNotifier {
  MissionViewModel();

  // Lista interna de missões
  List<MissionModel> _missions = [];

  // Indicador de carregamento
  bool _isLoading = false;

  // Mensagem de erro, se houver
  String? _errorMessage;

  /// Retorna a lista atual de missões.
  List<MissionModel> get missions => _missions;

  /// Retorna [true] se os dados estiverem sendo carregados.
  bool get isLoading => _isLoading;

  /// Retorna a mensagem de erro atual ou [null] se não houver erro.
  String? get errorMessage => _errorMessage;

  /// Carrega as missões da fonte de dados e atualiza o estado.
  Future<void> loadMissions() async {}

}