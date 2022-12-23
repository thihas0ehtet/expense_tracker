class CategoryModel {
  final int? id;
  final String name;

  CategoryModel({this.id, required this.name});

  factory CategoryModel.fromJson(dynamic data) =>
      CategoryModel(id: data['id'], name: data['name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
