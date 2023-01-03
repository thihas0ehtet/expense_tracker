import 'dart:typed_data';

class TransactionModel {
  final int? id;
  final String type;
  final int accountId;
  final String category;
  final double amount;
  final String date;
  final Uint8List? image;
  final String? note;

  TransactionModel(
      {this.id,
      required this.type,
      required this.accountId,
      required this.category,
      required this.amount,
      required this.date,
      this.image,
      this.note});

  factory TransactionModel.fromJson(dynamic data) => TransactionModel(
      id: data['id'],
      type: data['type'],
      accountId: data['accountId'],
      category: data['category'],
      amount: data['amount'].toDouble(),
      date: data['date'],
      image: data['image'],
      note: data['note']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "accountId": accountId,
        "category": category,
        "amount": amount,
        "date": date,
        "image": image,
        "note": note,
      };
}
