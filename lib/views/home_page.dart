import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const Color primaryPurple = Color(0xFF4B1BFF);
const Color darkPurple = Color(0xFF2C1378);
const Color lightPurple = Color(0xFFF0EBFF);
const Color cyan = Color(0xFF00B7FF);
const Color background = Color(0xFFF4F6FA);
const Color darkText = Color(0xFF171821);

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> titles = [
    'Inicio',
    'QR',
    'Beneficios',
    'Billetera',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const InicioView(),
      const QRView(),
      const BeneficiosView(),
      const BilleteraView(),
      const PerfilView(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEDEFF4),
      body: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 430),
          color: background,
          child: SafeArea(
            child: pages[selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: Center(
        heightFactor: 1,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 430),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 16,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: NavigationBar(
            height: 72,
            selectedIndex: selectedIndex,
            backgroundColor: Colors.white,
            indicatorColor: lightPurple,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: primaryPurple),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Icon(Icons.qr_code_2),
                selectedIcon: Icon(Icons.qr_code_2, color: primaryPurple),
                label: 'QR',
              ),
              NavigationDestination(
                icon: Icon(Icons.card_giftcard_outlined),
                selectedIcon: Icon(Icons.card_giftcard, color: primaryPurple),
                label: 'Club',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet, color: primaryPurple),
                label: 'Billetera',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: primaryPurple),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* =========================
   INICIO
========================= */

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: lightPurple,
                child: const Icon(Icons.person, color: primaryPurple),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hola, Juan Pablo',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Bienvenido a tu cuenta Deuna',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.notifications_none, color: darkText),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [
                  primaryPurple,
                  Color(0xFF6A35FF),
                  Color(0xFF00B7FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryPurple.withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saldo disponible',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '\$24.75',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 22),
                    SizedBox(width: 8),
                    Text(
                      '850 puntos Club Deuna',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.qr_code_2,
                  title: 'Pagar QR',
                  subtitle: 'Escanea y paga',
                  color: primaryPurple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAction(
                  icon: Icons.add,
                  title: 'Recargar',
                  subtitle: 'Añade saldo',
                  color: cyan,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.send_rounded,
                  title: 'Enviar',
                  subtitle: 'Transferencia',
                  color: const Color(0xFFFF8A00),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAction(
                  icon: Icons.card_giftcard,
                  title: 'Beneficios',
                  subtitle: 'Club Deuna',
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            'Promoción destacada',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: darkText,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: darkPurple,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deuna Drop cercano',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Escanea un QR aliado y gana recompensas sorpresa.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Movimientos recientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: darkText,
            ),
          ),

          const SizedBox(height: 14),

          const _TransactionTile(
            icon: Icons.qr_code_2,
            title: 'Pago en cafetería',
            subtitle: 'QR Deuna · Hoy',
            amount: '-\$2.50',
            positive: false,
          ),
          const _TransactionTile(
            icon: Icons.arrow_downward,
            title: 'Cashback recibido',
            subtitle: 'Promoción Deuna Drop · Hoy',
            amount: '+\$1.00',
            positive: true,
          ),
          const _TransactionTile(
            icon: Icons.arrow_downward,
            title: 'Transferencia recibida',
            subtitle: 'María López · Ayer',
            amount: '+\$10.00',
            positive: true,
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: darkText,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   QR
========================= */

class QRView extends StatelessWidget {
  const QRView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Paga o cobra con QR',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: darkText,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Muestra este código para recibir pagos o escanea en comercios aliados.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 32),

          Container(
            width: 290,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 220,
                  height: 220,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: darkText, width: 7),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 49,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      final active = [
                        0, 1, 2, 5, 6,
                        7, 8, 10, 12, 13,
                        14, 16, 19, 20,
                        21, 22, 25,
                        28, 30, 33,
                        35, 36, 37, 38, 40,
                        42, 43, 44, 45, 46, 47
                      ].contains(index);

                      return Container(
                        decoration: BoxDecoration(
                          color: active ? darkText : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'DEUNA-099 999 9999',
                  style: TextStyle(
                    color: darkText,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Escáner QR simulado correctamente'),
                  ),
                );
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text(
                'Escanear QR de comercio',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: lightPurple,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: primaryPurple),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Usa este QR para cobrar, pagar o desbloquear beneficios en locales aliados.',
                    style: TextStyle(
                      color: darkText,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   BENEFICIOS
========================= */

class BeneficiosView extends StatelessWidget {
  const BeneficiosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Club Deuna',
            style: TextStyle(
              color: darkText,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Canjea beneficios, descuentos y recompensas reales.',
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: darkPurple,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: cyan,
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 34),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tus puntos',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '850',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: cyan,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Nivel Bronce',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Beneficios disponibles',
            style: TextStyle(
              color: darkText,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 14),

          const _BenefitCard(
            emoji: '🎁',
            title: 'Cashback sorpresa',
            subtitle: 'Paga con QR y recibe saldo promocional.',
            points: '150 puntos',
            tag: 'Popular',
          ),
          const _BenefitCard(
            emoji: '☕',
            title: 'Combo cafetería',
            subtitle: 'Descuento especial en locales aliados.',
            points: '250 puntos',
            tag: 'Aliado',
          ),
          const _BenefitCard(
            emoji: '📍',
            title: 'Deuna Drop',
            subtitle: 'Encuentra un punto cercano, escanea y gana.',
            points: '300 puntos',
            tag: 'Nuevo',
          ),
          const _BenefitCard(
            emoji: '📱',
            title: 'Recarga promocional',
            subtitle: 'Canjea puntos por beneficios móviles.',
            points: '200 puntos',
            tag: 'Club',
          ),
        ],
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String points;
  final String tag;

  const _BenefitCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF9FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  points,
                  style: const TextStyle(
                    color: primaryPurple,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: darkText,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Icon(Icons.chevron_right, color: darkText),
            ],
          ),
        ],
      ),
    );
  }
}

/* =========================
   BILLETERA
========================= */

class BilleteraView extends StatelessWidget {
  const BilleteraView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mi billetera',
            style: TextStyle(
              color: darkText,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 22),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saldo actual',
                  style: TextStyle(color: Colors.black45),
                ),
                const SizedBox(height: 8),
                const Text(
                  '\$24.75',
                  style: TextStyle(
                    color: darkText,
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _WalletButton(
                        icon: Icons.add,
                        label: 'Recargar',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _WalletButton(
                        icon: Icons.arrow_upward,
                        label: 'Retirar',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          const Text(
            'Tarjeta vinculada',
            style: TextStyle(
              color: darkText,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [darkPurple, primaryPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.credit_card, color: Colors.white, size: 34),
                SizedBox(height: 24),
                Text(
                  '**** **** **** 4582',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Juan Pablo Guama',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          const Text(
            'Historial',
            style: TextStyle(
              color: darkText,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 14),

          const _TransactionTile(
            icon: Icons.qr_code_2,
            title: 'Pago en cafetería',
            subtitle: 'QR Deuna · Hoy',
            amount: '-\$2.50',
            positive: false,
          ),
          const _TransactionTile(
            icon: Icons.arrow_downward,
            title: 'Cashback recibido',
            subtitle: 'Promoción Deuna Drop · Hoy',
            amount: '+\$1.00',
            positive: true,
          ),
          const _TransactionTile(
            icon: Icons.arrow_downward,
            title: 'Transferencia recibida',
            subtitle: 'María López · Ayer',
            amount: '+\$10.00',
            positive: true,
          ),
        ],
      ),
    );
  }
}

class _WalletButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _WalletButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightPurple,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: primaryPurple, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: primaryPurple,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* =========================
   PERFIL
========================= */

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 110),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 34, 22, 34),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryPurple, Color(0xFF00B7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 54,
                    color: primaryPurple,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'Juan Pablo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'juanpablo@demo.com',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                _ProfileOption(
                  icon: Icons.phone_android,
                  title: 'Teléfono',
                  subtitle: '099 999 9999',
                ),
                _ProfileOption(
                  icon: Icons.shield_outlined,
                  title: 'Seguridad',
                  subtitle: 'PIN y verificación',
                ),
                _ProfileOption(
                  icon: Icons.location_on_outlined,
                  title: 'Deuna Drop',
                  subtitle: 'Activar ubicación para recompensas',
                ),
                _ProfileOption(
                  icon: Icons.help_outline,
                  title: 'Ayuda',
                  subtitle: 'Soporte y preguntas frecuentes',
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Cerrar sesión',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFEAF9FF),
            child: Icon(icon, color: primaryPurple),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkText,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: darkText),
        ],
      ),
    );
  }
}

/* =========================
   COMPONENTE TRANSACCIONES
========================= */

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool positive;

  const _TransactionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.positive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: positive
                ? const Color(0xFFE8FFF2)
                : const Color(0xFFEAF9FF),
            child: Icon(
              icon,
              color: positive ? const Color(0xFF22C55E) : primaryPurple,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkText,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: positive ? const Color(0xFF22C55E) : darkText,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}