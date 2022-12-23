import 'dart:typed_data';

class TransactionModel {
  final int? id;
  final String type;
  final int accountId;
  final int categoryId;
  final double amount;
  final String date;
  final Uint8List? image;
  final String? note;

  TransactionModel(
      {this.id,
      required this.type,
      required this.accountId,
      required this.categoryId,
      required this.amount,
      required this.date,
      this.image,
      this.note});

  factory TransactionModel.fromJson(dynamic data) => TransactionModel(
      id: data['id'],
      type: data['type'],
      accountId: data['accountId'],
      categoryId: data['categoryId'],
      amount: data['amount'].toDouble(),
      date: data['date'],
      image: data['image'],
      note: data['note']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "accountId": accountId,
        "categoryId": categoryId,
        "amount": amount,
        "date": date,
        "image": image,
        "note": note,
      };
}
