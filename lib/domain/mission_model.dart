class MissionModel {
  final int id;
  final String name;
  final String launchDate;
  final String status;

  MissionModel({
    required this.id,
    required this.name,
    required this.launchDate,
    required this.status,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      launchDate:
          (json['launchDate'] ?? json['launch_date'] ?? '') as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'launch_date': launchDate,
      'status': status,
    };
  }
}
