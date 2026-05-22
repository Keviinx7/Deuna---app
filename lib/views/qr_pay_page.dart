import 'package:flutter/material.dart';
import '../controllers/deuna_controller.dart';

class QrPayPage extends StatelessWidget {
  final DeunaController controller;

  const QrPayPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final qrCode = controller.getUserQr();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text('Paga o cobra con QR', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('Muestra este código para recibir pagos o escanea en comercios aliados.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
              child: Column(
                children: [
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF111827), width: 8),
                    ),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(18),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                      itemCount: 49,
                      itemBuilder: (_, index) {
                        final filled = [0, 1, 2, 7, 14, 8, 16, 21, 22, 28, 30, 35, 40, 42, 43, 44, 6, 13, 20, 5, 12, 19, 36, 37, 38, 45, 46, 47].contains(index) || index % 5 == 0;
                        return Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: filled ? const Color(0xFF111827) : Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(qrCode, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B6E3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Escaneo QR simulado correctamente')));
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Escanear QR de comercio', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
