import 'package:injestao_dependencias/data/mission_remote_service.dart';
import 'package:injestao_dependencias/domain/mission_model.dart';

abstract class MissionRepository {
  Future<List<MissionModel>> getMissions();
}

class MissionRepositoryImpl implements MissionRepository {
  final MissionRemoteService _service;
  
  MissionRepositoryImpl(this._service);
  @override
  Future<List<MissionModel>> getMissions() {
    return _service.getMission();
  }
}