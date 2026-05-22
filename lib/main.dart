import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const DeunaReplicaApp());
}

const Color deunaPurple = Color(0xFF4B178B);
const Color deunaDarkPurple = Color(0xFF3B126F);
const Color deunaLightPurple = Color(0xFFEDE3FA);
const Color deunaMint = Color(0xFF69E7D1);
const Color deunaText = Color(0xFF15151A);
const Color deunaGray = Color(0xFF7B7B86);
const Color deunaLine = Color(0xFFE7E7E7);

class DeunaReplicaApp extends StatelessWidget {
  const DeunaReplicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deuna Replica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}

class Movement {
  final String title;
  final String subtitle;
  final double amount;
  final IconData icon;
  final bool positive;

  Movement({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.positive,
  });
}

class ActionResult {
  final String title;
  final String subtitle;
  final double amount;

  ActionResult({
    required this.title,
    required this.subtitle,
    required this.amount,
  });
}

class DemoWallet {
  double balance = 142.79;
  int points = 30;

  final List<Movement> movements = [
    Movement(
      title: 'Saldo inicial',
      subtitle: 'Principal ******7359 · Hoy',
      amount: 142.79,
      icon: Icons.account_balance_wallet,
      positive: true,
    ),
  ];

  String get formattedBalance {
    return '\$${balance.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  bool hasEnough(double value) {
    return balance >= value;
  }

  void addMoney({
    required String title,
    required String subtitle,
    required double value,
    required IconData icon,
  }) {
    balance += value;
    movements.insert(
      0,
      Movement(
        title: title,
        subtitle: subtitle,
        amount: value,
        icon: icon,
        positive: true,
      ),
    );
  }

  bool subtractMoney({
    required String title,
    required String subtitle,
    required double value,
    required IconData icon,
  }) {
    if (!hasEnough(value)) return false;

    balance -= value;
    points += 5;

    movements.insert(
      0,
      Movement(
        title: title,
        subtitle: subtitle,
        amount: -value,
        icon: icon,
        positive: false,
      ),
    );

    return true;
  }
}

class PhoneShell extends StatelessWidget {
  final Widget child;
  final Color background;

  const PhoneShell({
    super.key,
    required this.child,
    this.background = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEFF4),
      body: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 430),
          color: background,
          child: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}

class FakeStatusBar extends StatelessWidget {
  final Color color;
  final bool dark;

  const FakeStatusBar({
    super.key,
    this.color = Colors.white,
    this.dark = true,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class DeunaLogo extends StatelessWidget {
  final double size;
  final Color color;

  const DeunaLogo({
    super.key,
    this.size = 44,
    this.color = deunaPurple,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'deuna!',
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        letterSpacing: -2,
      ),
    );
  }
}

/* =========================
   SPLASH
========================= */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainQrScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const PhoneShell(
      background: deunaDarkPurple,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: DeunaLogo(
                color: Colors.white,
                size: 52,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: SizedBox(
              width: 150,
              height: 5,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   QR INICIAL
========================= */

class MainQrScreen extends StatelessWidget {
  const MainQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneShell(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const DeunaLogo(size: 42),
                  const SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 280,
                        height: 280,
                        child: CustomPaint(
                          painter: QrCornersPainter(),
                        ),
                      ),
                      SizedBox(
                        width: 230,
                        height: 230,
                        child: CustomPaint(
                          painter: FakeQrPainter(),
                        ),
                      ),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'd!',
                            style: TextStyle(
                              color: deunaPurple,
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Usa este QR o Nro de cuenta para cobrar',
                    style: TextStyle(
                      color: deunaText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nro. ******6316',
                        style: TextStyle(
                          color: deunaText,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.visibility_off),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      QrOption(
                        icon: Icons.directions_subway,
                        title: 'Metro UIO',
                      ),
                      QrOption(
                        icon: Icons.qr_code_scanner,
                        title: 'Escanear QR',
                        openScanner: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 62,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deunaPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Ingresar a Deuna',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QrOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool openScanner;

  const QrOption({
    super.key,
    required this.icon,
    required this.title,
    this.openScanner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: deunaLightPurple,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () async {
              if (openScanner) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CameraQrScannerPage(),
                  ),
                );
              } else {
                showInfoDialog(
                  context,
                  title,
                  'Función activada correctamente.',
                  icon,
                );
              }
            },
            child: SizedBox(
              width: 76,
              height: 76,
              child: Icon(
                icon,
                color: deunaPurple,
                size: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: deunaText,
          ),
        ),
      ],
    );
  }
}

/* =========================
   HOME
========================= */

enum DeunaTab { inicio, beneficios, billetera, tu }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DemoWallet wallet = DemoWallet();
  DeunaTab selectedTab = DeunaTab.inicio;
  bool showNotification = false;

  final List<DeunaTab> tabs = [
    DeunaTab.inicio,
    DeunaTab.beneficios,
    DeunaTab.billetera,
    DeunaTab.tu,
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        showNotification = true;
      });
    });
  }

  void changeTabBySwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 250) return;

    final currentIndex = tabs.indexOf(selectedTab);

    if (velocity < 0 && currentIndex < tabs.length - 1) {
      setState(() {
        selectedTab = tabs[currentIndex + 1];
      });
    }

    if (velocity > 0 && currentIndex > 0) {
      setState(() {
        selectedTab = tabs[currentIndex - 1];
      });
    }
  }

  void showNoMoney(double value) {
    showInfoDialog(
      context,
      'Saldo insuficiente',
      'No tienes saldo suficiente.\n\nMonto requerido: \$${value.toStringAsFixed(2)}\nSaldo actual: ${wallet.formattedBalance}',
      Icons.warning_amber_rounded,
    );
  }

  void processPayment({
    required String title,
    required String subtitle,
    required double value,
    required IconData icon,
  }) {
    final ok = wallet.subtractMoney(
      title: title,
      subtitle: subtitle,
      value: value,
      icon: icon,
    );

    if (!ok) {
      showNoMoney(value);
      return;
    }

    setState(() {});

    showInfoDialog(
      context,
      'Operación realizada',
      'Se descontó \$${value.toStringAsFixed(2)} de tu saldo.\n\nSaldo actual: ${wallet.formattedBalance}\nGanaste +5 puntos DeunaDrops.',
      Icons.check_circle,
    );
  }

  void processIncome({
    required String title,
    required String subtitle,
    required double value,
    required IconData icon,
  }) {
    wallet.addMoney(
      title: title,
      subtitle: subtitle,
      value: value,
      icon: icon,
    );

    setState(() {});

    showInfoDialog(
      context,
      'Saldo actualizado',
      'Se agregó \$${value.toStringAsFixed(2)} a tu cuenta.\n\nSaldo actual: ${wallet.formattedBalance}',
      Icons.check_circle,
    );
  }

  Future<void> openQrPayment() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const CameraQrScannerPage(),
      ),
    );

    if (result != null && result.isNotEmpty) {
      processPayment(
        title: 'Pago con QR escaneado',
        subtitle: 'Código: $result · Ahora',
        value: 2.50,
        icon: Icons.qr_code_2,
      );
    }
  }

  Future<void> openOperation(String action, IconData icon) async {
    final result = await Navigator.push<ActionResult>(
      context,
      MaterialPageRoute(
        builder: (_) => OperationPage(
          title: action,
          icon: icon,
          wallet: wallet,
        ),
      ),
    );

    if (result == null) return;

    if (result.amount >= 0) {
      processIncome(
        title: result.title,
        subtitle: result.subtitle,
        value: result.amount,
        icon: icon,
      );
    } else {
      processPayment(
        title: result.title,
        subtitle: result.subtitle,
        value: result.amount.abs(),
        icon: icon,
      );
    }
  }

  Future<void> openDrops() async {
    final points = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => DeunaDropsPage(
          initialPoints: wallet.points,
        ),
      ),
    );

    if (points != null) {
      setState(() {
        wallet.points = points;
      });
    }
  }

  Widget get currentPage {
    switch (selectedTab) {
      case DeunaTab.inicio:
        return InicioPage(
          wallet: wallet,
          showNotification: showNotification,
          onCloseNotification: () {
            setState(() {
              showNotification = false;
            });
          },
          onOpenDrops: openDrops,
          onAction: openOperation,
        );

      case DeunaTab.beneficios:
        return BenefitsPage(
          wallet: wallet,
          onUseBenefit: () {
            if (wallet.points < 5) {
              showInfoDialog(
                context,
                'Puntos insuficientes',
                'Necesitas al menos 5 puntos para canjear este beneficio.',
                Icons.warning_amber_rounded,
              );
              return;
            }

            setState(() {
              wallet.points -= 5;
            });

            showInfoDialog(
              context,
              'Beneficio canjeado',
              'Canjeaste un beneficio del Club Deuna.\n\nPuntos actuales: ${wallet.points}',
              Icons.card_giftcard,
            );
          },
        );

      case DeunaTab.billetera:
        return WalletPage(
          wallet: wallet,
          onAction: openOperation,
        );

      case DeunaTab.tu:
        return ProfilePage(
          onOptionTap: (title, icon) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InfoPage(
                  title: title,
                  icon: icon,
                ),
              ),
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhoneShell(
      child: GestureDetector(
        onHorizontalDragEnd: changeTabBySwipe,
        child: Stack(
          children: [
            Positioned.fill(child: currentPage),
            if (selectedTab == DeunaTab.inicio)
              Positioned(
                left: 22,
                right: 22,
                bottom: 88,
                child: SizedBox(
                  height: 58,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: deunaPurple,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: openQrPayment,
                    icon: const Icon(Icons.qr_code_2),
                    label: const Text(
                      'Escanear QR',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNav(
                selected: selectedTab,
                onChanged: (tab) {
                  setState(() {
                    selectedTab = tab;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   INICIO
========================= */

class InicioPage extends StatelessWidget {
  final DemoWallet wallet;
  final bool showNotification;
  final VoidCallback onCloseNotification;
  final VoidCallback onOpenDrops;
  final void Function(String action, IconData icon) onAction;

  const InicioPage({
    super.key,
    required this.wallet,
    required this.showNotification,
    required this.onCloseNotification,
    required this.onOpenDrops,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 175),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderHome(onOpenDrops: onOpenDrops),
                    const SizedBox(height: 20),
                    BalanceCard(wallet: wallet),
                    const SizedBox(height: 18),
                    const PromoBanner(),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: onOpenDrops,
                      child: DropsBanner(points: wallet.points),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        '● ● ○ ○',
                        style: TextStyle(
                          color: deunaPurple,
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Wrap(
                      spacing: 14,
                      runSpacing: 22,
                      children: [
                        HomeAction(
                          icon: Icons.move_up,
                          label: 'Transferir',
                          onTap: () => onAction(
                            'Transferir',
                            Icons.move_up,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.account_balance,
                          label: 'Transferir a\notro banco',
                          onTap: () => onAction(
                            'Transferir a otro banco',
                            Icons.account_balance,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.wallet,
                          label: 'Recargar',
                          onTap: () => onAction(
                            'Recargar',
                            Icons.wallet,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.credit_card,
                          label: 'Cobrar',
                          onTap: () => onAction(
                            'Cobrar',
                            Icons.credit_card,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.storefront,
                          label: 'Retirar',
                          onTap: () => onAction(
                            'Retirar',
                            Icons.storefront,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.phone_iphone,
                          label: 'Recarga\ncelular',
                          onTap: () => onAction(
                            'Recarga celular',
                            Icons.phone_iphone,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.receipt_long,
                          label: 'Pagar\nservicios',
                          onTap: () => onAction(
                            'Pagar servicios',
                            Icons.receipt_long,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.directions_subway,
                          label: 'Metro de\nQuito',
                          onTap: () => onAction(
                            'Metro de Quito',
                            Icons.directions_subway,
                          ),
                        ),
                        HomeAction(
                          icon: Icons.groups,
                          label: 'Deuna\nJóvenes',
                          onTap: () {
                            showInfoDialog(
                              context,
                              'Deuna Jóvenes',
                              'Cuenta juvenil activada correctamente.',
                              Icons.groups,
                            );
                          },
                        ),
                        HomeAction(
                          icon: Icons.shopping_cart,
                          label: 'Tienda\nDeuna',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StorePage(wallet: wallet),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Movimientos recientes',
                      style: TextStyle(
                        color: deunaText,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (final item in wallet.movements.take(5))
                      MovementTile(movement: item),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeOutBack,
                top: showNotification ? 4 : -130,
                left: 14,
                right: 14,
                child: GestureDetector(
                  onTap: onOpenDrops,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 350),
                    opacity: showNotification ? 1 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 18,
                            offset: Offset(0, 8),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFFE9E0FF),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: const BoxDecoration(
                              color: deunaPurple,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nuevo DeunaDrop cerca de ti',
                                  style: TextStyle(
                                    color: deunaText,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Tienes 24 horas para reclamar tu recompensa.',
                                  style: TextStyle(
                                    color: deunaGray,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: onCloseNotification,
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderHome extends StatelessWidget {
  final VoidCallback onOpenDrops;

  const HeaderHome({
    super.key,
    required this.onOpenDrops,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 21,
          backgroundColor: deunaPurple,
          child: Text(
            'JG',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Hola Juan',
          style: TextStyle(
            color: deunaText,
            fontSize: 23,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFFF855D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'd!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onOpenDrops,
          child: const Icon(
            Icons.notifications_none,
            size: 30,
          ),
        ),
        const SizedBox(width: 18),
        const Icon(
          Icons.headphones_outlined,
          size: 30,
        ),
      ],
    );
  }
}

class BalanceCard extends StatefulWidget {
  final DemoWallet wallet;

  const BalanceCard({
    super.key,
    required this.wallet,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool showBalance = true;

  @override
  Widget build(BuildContext context) {
    final hiddenBalance = '\$••••';

    return GestureDetector(
      onTap: () => showBalanceSheet(context, widget.wallet),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: deunaLine),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Saldo disponible',
                          style: TextStyle(
                            color: deunaGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              showBalance
                                  ? widget.wallet.formattedBalance
                                  : hiddenBalance,
                              style: const TextStyle(
                                color: deunaText,
                                fontSize: 38,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showBalance = !showBalance;
                                });
                              },
                              child: Icon(
                                showBalance
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 42,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recargar desde',
                          style: TextStyle(
                            color: deunaGray,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Principal ******7359',
                          style: TextStyle(
                            color: deunaText,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x15000000),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Text(
                      '+ \$20',
                      style: TextStyle(
                        color: deunaPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.double_arrow,
                    color: deunaGray,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'd!',
                    style: TextStyle(
                      color: deunaPurple,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFEADCF8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Gana una TV de 70”! Haz 3 pagos',
                  style: TextStyle(
                    color: deunaPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Conoce más ↗',
                  style: TextStyle(
                    color: deunaPurple,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 78,
            height: 62,
            decoration: BoxDecoration(
              color: deunaMint,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.card_giftcard,
              color: deunaPurple,
              size: 42,
            ),
          ),
        ],
      ),
    );
  }
}

class DropsBanner extends StatelessWidget {
  final int points;

  const DropsBanner({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6D7FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: deunaPurple.withOpacity(0.16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DeunaDrops cerca de ti',
                  style: TextStyle(
                    color: deunaPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Tienes $points puntos. Reclama tu recompensa ahora ↗',
                  style: const TextStyle(
                    color: deunaPurple,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 78,
            height: 62,
            decoration: BoxDecoration(
              color: deunaMint,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.location_on,
              color: deunaPurple,
              size: 42,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const HomeAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      child: Column(
        children: [
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFF1F1F1),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: deunaPurple,
                  size: 34,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: deunaText,
              fontSize: 15,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   OPERACIONES
========================= */

class OperationPage extends StatefulWidget {
  final String title;
  final IconData icon;
  final DemoWallet wallet;

  const OperationPage({
    super.key,
    required this.title,
    required this.icon,
    required this.wallet,
  });

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController targetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.text = defaultAmount(widget.title);
    targetController.text = defaultTarget(widget.title);
  }

  @override
  void dispose() {
    amountController.dispose();
    targetController.dispose();
    super.dispose();
  }

  bool get isIncome {
    return widget.title == 'Recargar' || widget.title == 'Cobrar';
  }

  void confirm() {
    final amount = double.tryParse(
          amountController.text.trim().replaceAll(',', '.'),
        ) ??
        0;

    if (amount <= 0) {
      showInfoDialog(
        context,
        'Monto inválido',
        'Ingresa un monto mayor a cero.',
        Icons.warning_amber_rounded,
      );
      return;
    }

    Navigator.pop(
      context,
      ActionResult(
        title: widget.title,
        subtitle: '${targetController.text} · Ahora',
        amount: isIncome ? amount : -amount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhoneShell(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTopBar(
                    title: widget.title,
                    icon: widget.icon,
                  ),
                  const SizedBox(height: 26),
                  Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: deunaLightPurple,
                      child: Icon(
                        widget.icon,
                        color: deunaPurple,
                        size: 52,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    operationTitle(widget.title),
                    style: const TextStyle(
                      color: deunaText,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    operationDescription(widget.title),
                    style: const TextStyle(
                      color: deunaGray,
                      fontSize: 15,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Saldo disponible: ${widget.wallet.formattedBalance}',
                    style: const TextStyle(
                      color: deunaPurple,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Cuenta origen',
                    style: TextStyle(
                      color: deunaText,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    readOnly: true,
                    decoration: inputDecoration(
                      hint: 'Principal ******7359',
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    targetLabel(widget.title),
                    style: const TextStyle(
                      color: deunaText,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: targetController,
                    decoration: inputDecoration(hint: 'Destino'),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Monto',
                    style: TextStyle(
                      color: deunaText,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration(prefix: '\$ '),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deunaPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: confirm,
                      child: Text(
                        isIncome ? 'Confirmar ingreso' : 'Confirmar pago',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String defaultAmount(String title) {
  switch (title) {
    case 'Recargar':
      return '20';
    case 'Cobrar':
      return '15';
    case 'Retirar':
      return '10';
    case 'Recarga celular':
      return '5';
    case 'Pagar servicios':
      return '12';
    case 'Metro de Quito':
      return '2';
    default:
      return '10';
  }
}

String defaultTarget(String title) {
  switch (title) {
    case 'Transferir':
      return 'María López - 0991234567';
    case 'Transferir a otro banco':
      return 'Banco Pichincha ******1234';
    case 'Recargar':
      return 'Principal ******7359';
    case 'Cobrar':
      return 'Cliente invitado';
    case 'Retirar':
      return 'Veci cercano';
    case 'Recarga celular':
      return 'Claro - 0999999999';
    case 'Pagar servicios':
      return 'Empresa Eléctrica Norte';
    case 'Metro de Quito':
      return 'Metro UIO';
    default:
      return 'Destino demo';
  }
}

String operationTitle(String title) {
  switch (title) {
    case 'Transferir':
      return 'Enviar dinero';
    case 'Transferir a otro banco':
      return 'Transferencia bancaria';
    case 'Recargar':
      return 'Recargar saldo';
    case 'Cobrar':
      return 'Solicitar cobro';
    case 'Retirar':
      return 'Retirar dinero';
    case 'Recarga celular':
      return 'Recargar celular';
    case 'Pagar servicios':
      return 'Pagar servicios';
    case 'Metro de Quito':
      return 'Pagar Metro de Quito';
    default:
      return title;
  }
}

String operationDescription(String title) {
  switch (title) {
    case 'Recargar':
      return 'Esta operación aumenta tu saldo disponible.';
    case 'Cobrar':
      return 'Esta operación simula un cobro recibido y aumenta tu saldo.';
    default:
      return 'Esta operación descuenta saldo de tu cuenta principal y suma puntos DeunaDrops.';
  }
}

String targetLabel(String title) {
  if (title == 'Pagar servicios') return 'Servicio';
  if (title == 'Metro de Quito') return 'Destino';
  if (title == 'Recarga celular') return 'Operadora y número';
  if (title == 'Retirar') return 'Punto de retiro';
  if (title == 'Cobrar') return 'Persona a cobrar';
  return 'Destinatario';
}

InputDecoration inputDecoration({String? hint, String? prefix}) {
  return InputDecoration(
    hintText: hint,
    prefixText: prefix,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: deunaLine),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        color: deunaPurple,
        width: 2,
      ),
    ),
  );
}

/* =========================
   DEUNADROPS
========================= */

class DeunaDropsPage extends StatefulWidget {
  final int initialPoints;

  const DeunaDropsPage({
    super.key,
    required this.initialPoints,
  });

  @override
  State<DeunaDropsPage> createState() => _DeunaDropsPageState();
}

class _DeunaDropsPageState extends State<DeunaDropsPage> {
  late int points;
  late DateTime expiresAt;
  Timer? timer;
  Duration remaining = const Duration(hours: 24);
  int nextDropIndex = 3;

  late List<Map<String, dynamic>> visibleDrops;

  final List<Map<String, dynamic>> allDrops = [
    {
      'title': 'Drop Cafetería UPEC',
      'subtitle': 'Cafetería aliada · 300 m',
      'description':
          'Escanea el QR del local y desbloquea una recompensa sorpresa.',
      'reward': 'Combo sorpresa gratis',
      'icon': Icons.local_cafe,
      'color': const Color(0xFFFFD6A5),
    },
    {
      'title': 'Drop Metro UIO',
      'subtitle': 'Transporte aliado · 650 m',
      'description': 'Realiza un pago con Deuna y desbloquea un cupón especial.',
      'reward': 'Cupón de viaje promocional',
      'icon': Icons.directions_subway,
      'color': const Color(0xFFD8C2FF),
    },
    {
      'title': 'Drop Tienda Deuna',
      'subtitle': 'Comercio afiliado · 1.2 km',
      'description': 'Compra en comercio aliado y participa por premios.',
      'reward': 'Descuento exclusivo',
      'icon': Icons.shopping_bag,
      'color': const Color(0xFFC8F7DC),
    },
    {
      'title': 'Drop Farmacia Aliada',
      'subtitle': 'Salud y bienestar · 500 m',
      'description': 'Paga con Deuna y recibe un beneficio promocional.',
      'reward': 'Cupón de descuento en farmacia',
      'icon': Icons.local_pharmacy,
      'color': const Color(0xFFC7E9FF),
    },
    {
      'title': 'Drop Restaurante Centro',
      'subtitle': 'Comida aliada · 850 m',
      'description': 'Realiza una compra y desbloquea una promoción limitada.',
      'reward': 'Bebida gratis en combo',
      'icon': Icons.restaurant,
      'color': const Color(0xFFFFCFE1),
    },
    {
      'title': 'Drop Librería Universitaria',
      'subtitle': 'Comercio académico · 1 km',
      'description': 'Compra útiles o copias y gana una recompensa sorpresa.',
      'reward': 'Descuento en impresiones',
      'icon': Icons.menu_book,
      'color': const Color(0xFFDFFFD6),
    },
    {
      'title': 'Drop Transporte Local',
      'subtitle': 'Movilidad aliada · 750 m',
      'description': 'Usa Deuna para pagar y recibe una promoción temporal.',
      'reward': 'Viaje promocional',
      'icon': Icons.directions_bus,
      'color': const Color(0xFFFFE0A8),
    },
  ];

  @override
  void initState() {
    super.initState();
    points = widget.initialPoints;
    expiresAt = DateTime.now().add(const Duration(hours: 24));
    visibleDrops = List<Map<String, dynamic>>.from(allDrops.take(3));

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      final diff = expiresAt.difference(DateTime.now());

      setState(() {
        remaining = diff.isNegative ? Duration.zero : diff;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get countdown {
    final h = remaining.inHours.toString().padLeft(2, '0');
    final m = remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  void claim(int index) {
    if (points < 20) {
      showInfoDialog(
        context,
        'DeunaDrop bloqueado',
        'Necesitas al menos 20 puntos para reclamar.',
        Icons.lock,
      );
      return;
    }

    final claimedReward = visibleDrops[index]['reward'];

    setState(() {
      points -= 3;

      final newDrop = allDrops[nextDropIndex % allDrops.length];
      visibleDrops[index] = Map<String, dynamic>.from(newDrop);
      nextDropIndex++;
    });

    showInfoDialog(
      context,
      'Recompensa reclamada',
      'Ganaste: $claimedReward\n\nSe liberó un nuevo DeunaDrop cerca de ti.\nPuntos actuales: $points',
      Icons.card_giftcard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhoneShell(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTopBar(
                    title: 'DeunaDrops',
                    icon: Icons.notifications_active,
                    onBack: () => Navigator.pop(context, points),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          deunaPurple,
                          Color(0xFF7D3CFF),
                          Color(0xFFB996FF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '¡Tienes un DeunaDrop cerca de ti!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Encuentra el comercio aliado, escanea el QR, paga con Deuna y reclama tu recompensa.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            DropPill(
                              icon: Icons.stars,
                              label: '$points puntos',
                            ),
                            const SizedBox(width: 10),
                            DropPill(
                              icon: Icons.timer,
                              label: countdown,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Drops cercanos',
                    style: TextStyle(
                      color: deunaText,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Recompensas liberadas por comercios afiliados cerca de tu ubicación.',
                    style: TextStyle(color: deunaGray),
                  ),
                  const SizedBox(height: 18),
                  for (int i = 0; i < visibleDrops.length; i++)
                    DropCard(
                      title: visibleDrops[i]['title'],
                      subtitle: visibleDrops[i]['subtitle'],
                      description: visibleDrops[i]['description'],
                      reward: visibleDrops[i]['reward'],
                      icon: visibleDrops[i]['icon'],
                      color: visibleDrops[i]['color'],
                      onClaim: () => claim(i),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const DropPill({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.30),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class DropCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String reward;
  final IconData icon;
  final Color color;
  final VoidCallback onClaim;

  const DropCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.reward,
    required this.icon,
    required this.color,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: Container(
        key: ValueKey(title),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: deunaLine),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: deunaPurple,
                size: 34,
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
                      color: deunaText,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: deunaPurple,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      color: deunaGray,
                      fontSize: 12,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reward,
                    style: const TextStyle(
                      color: deunaText,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 90,
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: deunaPurple,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onClaim,
                child: const Text(
                  'Reclamar',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   CÁMARA QR REAL
========================= */

class CameraQrScannerPage extends StatefulWidget {
  const CameraQrScannerPage({super.key});

  @override
  State<CameraQrScannerPage> createState() => _CameraQrScannerPageState();
}

class _CameraQrScannerPageState extends State<CameraQrScannerPage>
    with SingleTickerProviderStateMixin {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  late AnimationController animationController;
  late Animation<double> animation;

  bool scanned = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  void onDetect(BarcodeCapture capture) {
    if (scanned) return;

    final String? code =
        capture.barcodes.isNotEmpty ? capture.barcodes.first.rawValue : null;

    if (code == null || code.isEmpty) return;

    setState(() {
      scanned = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        title: const Text(
          'QR detectado',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: Text(
          'Código leído correctamente:\n\n$code\n\nSe procesará como pago demo de \$2.50.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                scanned = false;
              });
            },
            child: const Text(
              'Escanear otro',
              style: TextStyle(
                color: deunaPurple,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: deunaPurple,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, code);
            },
            child: const Text('Confirmar pago'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhoneShell(
      background: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                  controller: controller,
                  onDetect: onDetect,
                ),
                Container(
                  color: Colors.black.withOpacity(0.18),
                ),
                Positioned(
                  top: 18,
                  left: 18,
                  right: 18,
                  child: Row(
                    children: [
                      CircleButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Escanear QR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      CircleButton(
                        icon: Icons.flash_on,
                        onTap: () => controller.toggleTorch(),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 280,
                    height: 280,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: const Size(280, 280),
                          painter: ScannerFramePainter(),
                        ),
                        AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Positioned(
                              top: 24 + (232 * animation.value),
                              left: 28,
                              right: 28,
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: deunaMint,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: deunaMint.withOpacity(0.7),
                                      blurRadius: 16,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 42,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              color: deunaPurple,
                              size: 30,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Apunta la cámara al QR del comercio para pagar.',
                                style: TextStyle(
                                  color: deunaText,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () => controller.switchCamera(),
                          icon: const Icon(Icons.cameraswitch),
                          label: const Text(
                            'Cambiar cámara',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white.withOpacity(0.95),
        child: Icon(
          icon,
          color: deunaPurple,
        ),
      ),
    );
  }
}

class ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final corner = Paint()
      ..color = deunaPurple
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        18,
        18,
        size.width - 36,
        size.height - 36,
      ),
      const Radius.circular(28),
    );

    canvas.drawRRect(rect, border);

    const double s = 22;
    const double l = 58;

    canvas.drawLine(const Offset(s, s), const Offset(s + l, s), corner);
    canvas.drawLine(const Offset(s, s), const Offset(s, s + l), corner);

    canvas.drawLine(
      Offset(size.width - s, s),
      Offset(size.width - s - l, s),
      corner,
    );
    canvas.drawLine(
      Offset(size.width - s, s),
      Offset(size.width - s, s + l),
      corner,
    );

    canvas.drawLine(
      Offset(s, size.height - s),
      Offset(s + l, size.height - s),
      corner,
    );
    canvas.drawLine(
      Offset(s, size.height - s),
      Offset(s, size.height - s - l),
      corner,
    );

    canvas.drawLine(
      Offset(size.width - s, size.height - s),
      Offset(size.width - s - l, size.height - s),
      corner,
    );
    canvas.drawLine(
      Offset(size.width - s, size.height - s),
      Offset(size.width - s, size.height - s - l),
      corner,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/* =========================
   BENEFICIOS
========================= */

class BenefitsPage extends StatelessWidget {
  final DemoWallet wallet;
  final VoidCallback onUseBenefit;

  const BenefitsPage({
    super.key,
    required this.wallet,
    required this.onUseBenefit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              children: [
                const SizedBox(height: 18),
                const Text(
                  'Beneficios',
                  style: TextStyle(
                    color: deunaText,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: deunaLine),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 82,
                          height: 82,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8F69),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Center(
                            child: Text(
                              'd!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Text(
                            'Nivel Bronce\nTienes ${wallet.points} puntos acumulados.',
                            style: const TextStyle(
                              color: deunaText,
                              fontSize: 18,
                              height: 1.3,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                BenefitRow(
                  icon: Icons.casino,
                  title: 'Hasta 1 giro de Gira y Gana',
                  subtitle: 'Canjea 5 puntos para tener una chance de ganar.',
                  onTap: onUseBenefit,
                ),
                BenefitRow(
                  icon: Icons.local_offer,
                  title: 'Combos y promociones',
                  subtitle: 'Recibe descuentos, combos y promos únicas.',
                  onTap: onUseBenefit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BenefitRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const BenefitRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 8, 14, 18),
        margin: const EdgeInsets.only(bottom: 18),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: deunaLine),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 70,
              child: Icon(
                icon,
                color: deunaPurple,
                size: 38,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: deunaText,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF5D6372),
                      fontSize: 18,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 34,
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   BILLETERA
========================= */

class WalletPage extends StatelessWidget {
  final DemoWallet wallet;
  final void Function(String action, IconData icon) onAction;

  const WalletPage({
    super.key,
    required this.wallet,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppTopBar(
                  title: 'Billetera',
                  icon: Icons.visibility,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Cuentas',
                  style: TextStyle(
                    color: deunaText,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 22),
                AccountRow(
                  iconText: 'd!',
                  iconColor: deunaPurple,
                  title: 'Deuna ******6316',
                  amount: wallet.formattedBalance,
                  onTap: () => showBalanceSheet(context, wallet),
                ),
                AccountRow(
                  iconText: '▣',
                  iconColor: const Color(0xFFFFDD00),
                  title: 'Principal ******7359',
                  amount: wallet.formattedBalance,
                  onTap: () => showBalanceSheet(context, wallet),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: WalletActionButton(
                        label: 'Recargar',
                        icon: Icons.add,
                        onTap: () => onAction(
                          'Recargar',
                          Icons.wallet,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: WalletActionButton(
                        label: 'Retirar',
                        icon: Icons.arrow_upward,
                        onTap: () => onAction(
                          'Retirar',
                          Icons.storefront,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Historial',
                  style: TextStyle(
                    color: deunaText,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                for (final item in wallet.movements)
                  MovementTile(movement: item),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AccountRow extends StatelessWidget {
  final String iconText;
  final Color iconColor;
  final String title;
  final String amount;
  final VoidCallback onTap;

  const AccountRow({
    super.key,
    required this.iconText,
    required this.iconColor,
    required this.title,
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDeuna = iconText == 'd!';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: iconColor,
              child: Text(
                iconText,
                style: TextStyle(
                  color: isDeuna ? deunaMint : Colors.black,
                  fontSize: isDeuna ? 24 : 20,
                  fontWeight: FontWeight.w900,
                  fontStyle: isDeuna ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: deunaText,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(
                    color: deunaText,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WalletActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const WalletActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: deunaLightPurple,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: deunaPurple,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: deunaPurple,
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

class ProfilePage extends StatelessWidget {
  final void Function(String title, IconData icon) onOptionTap;

  const ProfilePage({
    super.key,
    required this.onOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: deunaPurple,
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 58),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 38),
                    Container(
                      width: 92,
                      height: 92,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9FFF3),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'JG',
                          style: TextStyle(
                            color: Color(0xFF056548),
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Juan Guama',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Última sesión: 21 may. 2026 | 12:27',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Versión 5.2.75.1355',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 30, 22, 110),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileOption(
                          icon: Icons.person_outline,
                          title: 'Información personal',
                          onTap: () => onOptionTap(
                            'Información personal',
                            Icons.person_outline,
                          ),
                        ),
                        ProfileOption(
                          icon: Icons.face_retouching_natural,
                          title: 'Apariencia',
                          onTap: () => onOptionTap(
                            'Apariencia',
                            Icons.face_retouching_natural,
                          ),
                        ),
                        ProfileOption(
                          icon: Icons.settings_outlined,
                          title: 'Configuración de límites',
                          onTap: () => onOptionTap(
                            'Configuración de límites',
                            Icons.settings_outlined,
                          ),
                        ),
                        ProfileOption(
                          icon: Icons.wifi_off,
                          title: 'Pagos sin internet',
                          onTap: () => onOptionTap(
                            'Pagos sin internet',
                            Icons.wifi_off,
                          ),
                        ),
                        ProfileOption(
                          icon: Icons.lock_outline,
                          title: 'Cambio de clave',
                          onTap: () => onOptionTap(
                            'Cambio de clave',
                            Icons.lock_outline,
                          ),
                        ),
                        ProfileOption(
                          icon: Icons.storefront_outlined,
                          title: 'Mi negocio',
                          onTap: () => onOptionTap(
                            'Mi negocio',
                            Icons.storefront_outlined,
                          ),
                        ),
                        ProfileOption(
                          icon: Icons.logout,
                          title: 'Cerrar sesión',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SplashScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 66,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: deunaLine),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: deunaText,
            ),
            const SizedBox(width: 28),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: deunaText,
                  fontSize: 22,
                ),
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

/* =========================
   TIENDA
========================= */

class StorePage extends StatefulWidget {
  final DemoWallet wallet;

  const StorePage({
    super.key,
    required this.wallet,
  });

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  void buy(String title, double price, IconData icon) {
    final ok = widget.wallet.subtractMoney(
      title: 'Compra en Tienda Deuna',
      subtitle: '$title · Ahora',
      value: price,
      icon: icon,
    );

    if (!ok) {
      showInfoDialog(
        context,
        'Saldo insuficiente',
        'No tienes saldo suficiente para comprar $title.\n\nPrecio: \$${price.toStringAsFixed(2)}\nSaldo actual: ${widget.wallet.formattedBalance}',
        Icons.warning_amber_rounded,
      );
      return;
    }

    setState(() {});

    showInfoDialog(
      context,
      'Compra realizada',
      'Compraste $title por \$${price.toStringAsFixed(2)}.\n\nSaldo actual: ${widget.wallet.formattedBalance}',
      Icons.check_circle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'title': 'Combo café',
        'price': 2.50,
        'icon': Icons.local_cafe,
      },
      {
        'title': 'Cupón transporte',
        'price': 1.00,
        'icon': Icons.directions_bus,
      },
      {
        'title': 'Descuento comida',
        'price': 3.00,
        'icon': Icons.fastfood,
      },
      {
        'title': 'Recarga promo',
        'price': 5.00,
        'icon': Icons.phone_android,
      },
    ];

    return PhoneShell(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
              children: [
                const AppTopBar(
                  title: 'Tienda Deuna',
                  icon: Icons.shopping_cart,
                ),
                const SizedBox(height: 24),
                Text(
                  'Saldo disponible: ${widget.wallet.formattedBalance}',
                  style: const TextStyle(
                    color: deunaPurple,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Productos y recompensas',
                  style: TextStyle(
                    color: deunaText,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                for (final product in products)
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: deunaLine),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: deunaLightPurple,
                          child: Icon(
                            product['icon'],
                            color: deunaPurple,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            product['title'],
                            style: const TextStyle(
                              color: deunaText,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Text(
                          '\$${product['price'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: deunaPurple,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: deunaPurple,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => buy(
                            product['title'],
                            product['price'],
                            product['icon'],
                          ),
                          child: const Text('Comprar'),
                        ),
                      ],
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
   INFO
========================= */

class InfoPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const InfoPage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneShell(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTopBar(
                    title: title,
                    icon: icon,
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: deunaLightPurple,
                      child: Icon(
                        icon,
                        color: deunaPurple,
                        size: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    title,
                    style: const TextStyle(
                      color: deunaText,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sección funcional en modo demostración.',
                    style: TextStyle(
                      color: deunaGray,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   COMPONENTES GENERALES
========================= */

class MovementTile extends StatelessWidget {
  final Movement movement;

  const MovementTile({
    super.key,
    required this.movement,
  });

  @override
  Widget build(BuildContext context) {
    final color = movement.positive ? const Color(0xFF16A34A) : deunaText;
    final sign = movement.positive ? '+' : '-';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: deunaLine),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: movement.positive
                ? const Color(0xFFE9FFF2)
                : deunaLightPurple,
            child: Icon(
              movement.icon,
              color: movement.positive ? const Color(0xFF16A34A) : deunaPurple,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movement.title,
                  style: const TextStyle(
                    color: deunaText,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  movement.subtitle,
                  style: const TextStyle(
                    color: deunaGray,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$sign\$${movement.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class AppTopBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onBack;

  const AppTopBar({
    super.key,
    required this.title,
    required this.icon,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack ?? () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: deunaText,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Icon(
          icon,
          color: deunaPurple,
        ),
      ],
    );
  }
}

void showInfoDialog(
  BuildContext context,
  String title,
  String message,
  IconData icon,
) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: deunaLightPurple,
            child: Icon(
              icon,
              color: deunaPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: deunaText,
              ),
            ),
          ),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Aceptar',
            style: TextStyle(
              color: deunaPurple,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    ),
  );
}

void showBalanceSheet(BuildContext context, DemoWallet wallet) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Detalle de saldo',
            style: TextStyle(
              color: deunaText,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: deunaPurple,
              child: Text(
                'd!',
                style: TextStyle(
                  color: deunaMint,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            title: const Text('Deuna ******6316'),
            subtitle: const Text('Cuenta principal'),
            trailing: Text(
              wallet.formattedBalance,
              style: const TextStyle(
                color: deunaPurple,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.stars,
              color: deunaPurple,
            ),
            title: const Text('Puntos DeunaDrops'),
            trailing: Text(
              '${wallet.points}',
              style: const TextStyle(
                color: deunaPurple,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/* =========================
   BOTTOM NAV
========================= */

class BottomNav extends StatelessWidget {
  final DeunaTab selected;
  final ValueChanged<DeunaTab> onChanged;

  const BottomNav({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: deunaLine),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.home,
            label: 'Inicio',
            selected: selected == DeunaTab.inicio,
            onTap: () => onChanged(DeunaTab.inicio),
          ),
          NavItem(
            icon: Icons.card_giftcard,
            label: 'Beneficios',
            selected: selected == DeunaTab.beneficios,
            onTap: () => onChanged(DeunaTab.beneficios),
          ),
          NavItem(
            icon: Icons.account_balance_wallet,
            label: 'Billetera',
            selected: selected == DeunaTab.billetera,
            onTap: () => onChanged(DeunaTab.billetera),
          ),
          NavItem(
            icon: Icons.account_circle_outlined,
            label: 'Tú',
            selected: selected == DeunaTab.tu,
            onTap: () => onChanged(DeunaTab.tu),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? deunaPurple : const Color(0xFF667085);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 86,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? deunaText : const Color(0xFF667085),
                fontSize: 14,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   DIBUJOS QR
========================= */

class QrCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = deunaPurple
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    const double c = 38;
    const double g = 30;

    canvas.drawLine(const Offset(0, g), const Offset(c, g), paint);
    canvas.drawLine(const Offset(0, g), const Offset(0, c + g), paint);

    canvas.drawLine(
      Offset(size.width, g),
      Offset(size.width - c, g),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, g),
      Offset(size.width, c + g),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height - g),
      Offset(c, size.height - g),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height - g),
      Offset(0, size.height - c - g),
      paint,
    );

    canvas.drawLine(
      Offset(size.width, size.height - g),
      Offset(size.width - c, size.height - g),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - g),
      Offset(size.width, size.height - c - g),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FakeQrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final black = Paint()..color = Colors.black;
    final white = Paint()..color = Colors.white;

    canvas.drawRect(Offset.zero & size, white);

    final cell = size.width / 29;

    for (int i = 0; i < 29; i++) {
      for (int j = 0; j < 29; j++) {
        final active = (i * j + i + j * 3) % 5 == 0 ||
            (i + j) % 7 == 0 ||
            (i * 2 + j) % 11 == 0;

        if (!active) continue;
        if (i > 9 && i < 19 && j > 9 && j < 19) continue;

        canvas.drawRect(
          Rect.fromLTWH(
            i * cell,
            j * cell,
            cell * 0.88,
            cell * 0.88,
          ),
          black,
        );
      }
    }

    void eye(double x, double y) {
      canvas.drawRect(
        Rect.fromLTWH(x, y, cell * 7, cell * 7),
        black,
      );
      canvas.drawRect(
        Rect.fromLTWH(x + cell, y + cell, cell * 5, cell * 5),
        white,
      );
      canvas.drawRect(
        Rect.fromLTWH(x + cell * 2, y + cell * 2, cell * 3, cell * 3),
        black,
      );
    }

    eye(cell, cell);
    eye(size.width - cell * 8, cell);
    eye(cell, size.height - cell * 8);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}