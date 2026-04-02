import 'package:flutter/material.dart';
import 'package:injestao_dependencias/core/http_client.dart';
import 'package:injestao_dependencias/domain/mission_model.dart';

class MissionRemoteService {
  final CustomHttpClient _clientHttps;
  MissionRemoteService(this._clientHttps);
  Future<List<MissionModel>> getMission() async{
    final response = await _clientHttps.get('/missions');
    final list = response.data as List<dynamic>;
    return list.map((e) => MissionModel.fromJson(e)).toList();
      }
}
