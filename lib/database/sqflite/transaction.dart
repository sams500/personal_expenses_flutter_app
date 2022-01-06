class Transaction {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {this.id, required this.title, required this.amount, required this.date});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['transactionID'] as int?,
        title: json['title'] as String,
        amount: json['amount'] as double,
        date: DateTime.parse(json['date'] as String),
      );

  Map<String, dynamic> toJson() => {
        'transactionID': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
      };

  Transaction copy({
    int? id,
    String? title,
    double? amount,
    DateTime? date,
  }) =>
      Transaction(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );
}
