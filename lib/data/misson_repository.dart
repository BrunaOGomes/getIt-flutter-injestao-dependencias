import 'package:injestao_dependencias/data/mission_remote_service.dart';
import 'package:injestao_dependencias/domain/mission_model.dart';

//define um contrato
abstract class MissionRepository {
  //Define o método que qualquer repositório deve ter
  /*Isso permite trocar a implementação:
  API
  Banco local
  Mock para testes*/
  Future<List<MissionModel>> getMissions();
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
}