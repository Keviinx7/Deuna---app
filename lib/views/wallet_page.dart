import 'package:flutter/material.dart';
import '../controllers/deuna_controller.dart';
import '../widgets/transaction_tile.dart';

class WalletPage extends StatelessWidget {
  final DeunaController controller;

  const WalletPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final user = controller.getUser();
    final transactions = controller.getTransactions();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mi billetera', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Saldo actual', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text('\$${user.balance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _WalletButton(icon: Icons.add, text: 'Recargar')),
                      const SizedBox(width: 12),
                      Expanded(child: _WalletButton(icon: Icons.arrow_upward, text: 'Retirar')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Historial', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(children: transactions.map((item) => TransactionTile(transaction: item)).toList()),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const _WalletButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE8F9FE),
        foregroundColor: const Color(0xFF00B6E3),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$text simulado'))),
      icon: Icon(icon),
      label: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
