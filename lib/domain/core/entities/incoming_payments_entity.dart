import 'package:wallet_guru/domain/core/models/response_model.dart';

class IncomingPaymentEntity {
  final String walletAddressId;
  final String id;
  final int assetScale;
  final String assetCode;
  final String value;

  IncomingPaymentEntity({
    required this.walletAddressId,
    required this.id,
    required this.assetScale,
    required this.assetCode,
    required this.value,
  });

  IncomingPaymentEntity copyWith({
    String? walletAddressId,
    String? id,
    int? assetScale,
    String? assetCode,
    String? value,
  }) {
    return IncomingPaymentEntity(
      walletAddressId: walletAddressId ?? this.walletAddressId,
      id: id ?? this.id,
      assetScale: assetScale ?? this.assetScale,
      assetCode: assetCode ?? this.assetCode,
      value: value ?? this.value,
    );
  }

  // Ajustamos para recibir un IncomingPayment y extraer la data relevante.
  factory IncomingPaymentEntity.fromIncomingPayment(
      IncomingPayment incomingPayment) {
    return IncomingPaymentEntity(
      walletAddressId: incomingPayment.walletAddressId,
      id: incomingPayment.id,
      assetScale: incomingPayment.incomingAmount.assetScale,
      assetCode: incomingPayment.incomingAmount.assetCode,
      value: incomingPayment.incomingAmount.value,
    );
  }
}
