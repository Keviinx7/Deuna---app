import 'package:flutter/material.dart';
import '../controllers/deuna_controller.dart';

class ProfilePage extends StatelessWidget {
  final DeunaController controller;

  const ProfilePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final user = controller.getUser();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFFE8F9FE),
              child: Icon(Icons.person, color: Color(0xFF00B6E3), size: 56),
            ),
            const SizedBox(height: 14),
            Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            Text(user.email, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 28),
            _ProfileOption(icon: Icons.phone_android, title: 'Teléfono', subtitle: user.phone),
            _ProfileOption(icon: Icons.security, title: 'Seguridad', subtitle: 'PIN y verificación'),
            _ProfileOption(icon: Icons.location_on_outlined, title: 'Deuna Drop', subtitle: 'Activar ubicación para recompensas'),
            _ProfileOption(icon: Icons.help_outline, title: 'Ayuda', subtitle: 'Soporte y preguntas frecuentes'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sesión cerrada en demo')));
                },
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileOption({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE8F9FE),
            child: Icon(icon, color: const Color(0xFF00B6E3)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }
}
