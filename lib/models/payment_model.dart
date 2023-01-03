class PaymentModel {
  final int? id;
  final String name;

  PaymentModel({this.id, required this.name});

  factory PaymentModel.fromJson(dynamic data) =>
      PaymentModel(id: data['id'], name: data['name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
