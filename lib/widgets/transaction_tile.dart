import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool positive = transaction.amount > 0;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: positive ? const Color(0xFFE8FFF2) : const Color(0xFFE8F9FE),
        child: Icon(
          positive ? Icons.arrow_downward_rounded : Icons.qr_code_rounded,
          color: positive ? Colors.green : const Color(0xFF00B6E3),
        ),
      ),
      title: Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${transaction.subtitle} · ${transaction.date}'),
      trailing: Text(
        '${positive ? '+' : '-'}\$${transaction.amount.abs().toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: positive ? Colors.green : Colors.black87,
        ),
      ),
    );
  }
}
