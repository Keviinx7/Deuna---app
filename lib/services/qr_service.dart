class QrService {
  String generateQrCode(String phone) {
    return 'DEUNA-$phone-QR-DEMO';
  }

  bool validatePayment(double amount) {
    return amount > 0;
  }
}
