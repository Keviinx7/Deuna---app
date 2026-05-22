import '../models/benefit.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';

class DeunaData {
  static const UserModel user = UserModel(
    name: 'Juan Pablo',
    phone: '099 999 9999',
    email: 'juanpablo@demo.com',
    balance: 24.75,
    points: 850,
  );

  static const List<Benefit> benefits = [
    Benefit(
      title: 'Cashback sorpresa',
      description: 'Paga con QR y recibe saldo promocional.',
      icon: '🎁',
      tag: 'Popular',
      points: 150,
    ),
    Benefit(
      title: 'Combo cafetería',
      description: 'Descuento especial en locales aliados.',
      icon: '☕',
      tag: 'Aliado',
      points: 250,
    ),
    Benefit(
      title: 'Deuna Drop',
      description: 'Encuentra un punto cercano, escanea y gana.',
      icon: '📍',
      tag: 'Nuevo',
      points: 300,
    ),
    Benefit(
      title: 'Recarga promocional',
      description: 'Canjea puntos por beneficios móviles.',
      icon: '📱',
      tag: 'Club',
      points: 200,
    ),
  ];

  static const List<TransactionModel> transactions = [
    TransactionModel(
      title: 'Pago en cafetería',
      subtitle: 'QR Deuna',
      amount: -2.50,
      type: 'Pago',
      date: 'Hoy',
    ),
    TransactionModel(
      title: 'Cashback recibido',
      subtitle: 'Promoción Deuna Drop',
      amount: 1.00,
      type: 'Beneficio',
      date: 'Hoy',
    ),
    TransactionModel(
      title: 'Transferencia recibida',
      subtitle: 'María López',
      amount: 10.00,
      type: 'Ingreso',
      date: 'Ayer',
    ),
  ];
}
