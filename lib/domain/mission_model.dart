class MissionModel {
  //final = sig que depois de criado n pode alterr o valor ==imutavel
  final int id;
  final String name;
  final String launchDate;
  final String status;
//construtor da classe
  MissionModel({
    required this.id,
    required this.name,
    required this.launchDate,
    required this.status,
  });
//constutor especial usado quando vc qr criar um objeto a partir de outra fonte (JSON aqui)
  factory MissionModel.fromJson(Map<String, dynamic> json) {
    //json convertido em mapa
    //aqui cria um novo obj MissionModel
    return MissionModel(
      //Pega o valor do JSON,Converte para número(pode ser int ou double),Garante que vira int
      id: (json['id'] as num).toInt(),
      //pega direto como string,se vier null da erro
      name: json['name'] ?? '' as String,
      //trata diferentes formatos de API
      //resolve API´s ionconsistentes
      launchDate:
          (json['launchDate'] ?? json['launch_date'] ?? '') as String,
          //conversao direta
      status: json['status'] as String,
    );
  }
//converte o obj para json,cria um mapa com os dados do objeto
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'launch_date': launchDate,
      'status': status,
    };
  }
}
