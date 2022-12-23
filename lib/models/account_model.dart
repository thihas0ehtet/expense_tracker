class AccountModel {
  final int? id;
  final String name;

  AccountModel({this.id, required this.name});

  factory AccountModel.fromJson(dynamic data) =>
      AccountModel(id: data['id'], name: data['name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
