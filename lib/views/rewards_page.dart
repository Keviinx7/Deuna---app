import 'package:flutter/material.dart';
import '../controllers/deuna_controller.dart';
import '../widgets/benefit_card.dart';

class RewardsPage extends StatelessWidget {
  final DeunaController controller;

  const RewardsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final benefits = controller.getBenefits();
    final user = controller.getUser();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Club Deuna', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('Canjea beneficios, descuentos y recompensas reales.', style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  const Icon(Icons.stars_rounded, color: Color(0xFF00B6E3), size: 44),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tus puntos', style: TextStyle(color: Colors.white70)),
                        Text('${user.points}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: const Color(0xFF00B6E3), borderRadius: BorderRadius.circular(20)),
                    child: const Text('Nivel Pro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Beneficios disponibles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            ...benefits.map(
              (benefit) => BenefitCard(
                benefit: benefit,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Beneficio seleccionado: ${benefit.title}')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
