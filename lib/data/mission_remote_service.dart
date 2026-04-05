import 'package:flutter/material.dart';
import 'package:injestao_dependencias/core/http_client.dart';
import 'package:injestao_dependencias/domain/mission_model.dart';

//classe que busca dados reemotos(API)
class MissionRemoteService {
  //declara o _clientHttps como privado ,que sera usado 
  //para fazer requisicoes
  final CustomHttpClient _clientHttps;
  //recebe o CustomHttpClient por injeção de dependência
  //facilita testar/trocar implementações
  MissionRemoteService(this._clientHttps);
  //retorna essa lista , Usa Future porque vem da internet
  Future<List<MissionModel>> getMission() async{
    //chama metodo get no endpoint
    final response = await _clientHttps.get('/missions');
    //Pega os dados da resposta. Faz um cast para List<dynamic>
    //cast = processo de converter um objeto de um tipo para outro,
    // garantindo segurança de tipos, geralmente usando a palavra-chave as
    final list = response.data as List<dynamic>;
    //percorre cada item da lista,converte cada Json em um objeto MissionModel
    //Transforma o resultado em lista novamente
    return list.map((e) => MissionModel.fromJson(e)).toList();
      }
}
