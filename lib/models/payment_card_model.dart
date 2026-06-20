
class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String holderName;
  final String expiryDate;
  final String cvvNumber;
  final bool isChoosen;

 const PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.holderName,
    required this.expiryDate,
    required this.cvvNumber,
    this.isChoosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? holderName,
    String? expiryDate,
    String? cvvNumber,
    bool? isChoosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      holderName: holderName ?? this.holderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvvNumber: cvvNumber?? this.cvvNumber,
      isChoosen: isChoosen??this.isChoosen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardNumber': cardNumber,
      'holderName': holderName,
      'expiryDate': expiryDate,
      'cvvNumber': cvvNumber,
      'isChoosen': isChoosen,
    };
  }

  factory PaymentCardModel.fromMap(Map<String, dynamic> map) {
    return PaymentCardModel(
      id: map['id'] as String,
      cardNumber: map['cardNumber'] as String,
      holderName: map['holderName'] as String,
      expiryDate: map['expiryDate'] as String,
      cvvNumber: map['cvvNumber'] as String,
      isChoosen: map['isChoosen'] as bool,
    );
  }

  }

// List<PaymentCardModel> paymentCards = [
//   PaymentCardModel(
//     id: '1',
//     cardNumber: '2323232323232334',
//     holderName: 'Kareem Mardy',
//     expiryDate: '02/2029',
//     cvvNumber: '123',
//   ),
//   PaymentCardModel(
//     id: '2',
//     cardNumber: '9493200394023044',
//     holderName: 'Ahmed Mardy',
//     expiryDate: '01/2028',
//     cvvNumber: '543',
//   ),
//   PaymentCardModel(
//     id: '3',
//     cardNumber: '2049530230459302',
//     holderName: 'Omar Mardy',
//     expiryDate: '02/2029',
//     cvvNumber: '976',
//   ),
// ];
