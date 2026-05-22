class TransactionModel {
  final String title;
  final String subtitle;
  final double amount;
  final String type;
  final String date;

  const TransactionModel({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.date,
  });
}
