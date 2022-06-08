class SmsModel {
  final int id;
  final int customerId;
  final String status;
  final String sentDate;
  final String itpDate;

  SmsModel(
      {required this.id,
      required this.customerId,
      required this.status,
      required this.sentDate,
      required this.itpDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'status': status,
      'sentDate': sentDate,
      'itpDate': itpDate
    };
  }
}
