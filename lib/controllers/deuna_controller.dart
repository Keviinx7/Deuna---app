import '../data/deuna_data.dart';
import '../models/benefit.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../services/qr_service.dart';

class DeunaController {
  final QrService _qrService = QrService();

  UserModel getUser() => DeunaData.user;

  List<Benefit> getBenefits() => DeunaData.benefits;

  List<TransactionModel> getTransactions() => DeunaData.transactions;

  String getUserQr() => _qrService.generateQrCode(DeunaData.user.phone);

  bool processPayment(double amount) => _qrService.validatePayment(amount);
}
