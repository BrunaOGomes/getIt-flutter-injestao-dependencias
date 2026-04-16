import '../domain/mission_model.dart';
import 'mission_remote_service.dart';

//define um contrato
abstract class MissionRepository {
  //Define o método que qualquer repositório deve ter
  /*Isso permite trocar a implementação:
  API
  Banco local
  Mock para testes*/
  Future<List<MissionModel>> getMissions();
    Future<bool> createMission(MissionModel mission);
}
//implementa contrato
class MissionRepositoryImpl implements MissionRepository {
  //usa o service que acessa a API
  final MissionRemoteService _service;
  //Recebe via construtor (injeção de dependência novamente)
  MissionRepositoryImpl(this._service);
  //apena delega o serviço
    @override
  Future<List<MissionModel>> getMissions() {
    return _service.getMission();
  }

  @override
  Future<bool> createMission(MissionModel mission) {
    return _service.createMission(mission);
  }
}