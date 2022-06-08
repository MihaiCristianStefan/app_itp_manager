class Customer {
  final String name;
  final String phone;
  final String carPlates;
  final String lastITP;
  final String nextITP;
  late int receivedSms;
  late int id = 0;
  late String createdAt;
  late String updatedAt;

  Customer(
      {required this.name,
      required this.phone,
      required this.carPlates,
      required this.lastITP,
      required this.nextITP,
      this.receivedSms: 0,
      this.id: 0});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'carPlates': carPlates,
      'lastITP': lastITP,
      'nextITP': nextITP,
      'receivedSms': receivedSms
    };
  }
}
