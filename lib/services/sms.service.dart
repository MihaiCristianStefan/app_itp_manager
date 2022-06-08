import 'dart:async';
import 'package:app_itp_manager/generated/l10n.dart';
import 'package:app_itp_manager/services/database.service.dart';
import 'package:app_itp_manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SmsService {
  void sendSMS(BuildContext context) async {
    var nextITPStartDate = DateTime.now().add(Duration(days: 7));
    var nextITPEndDate = nextITPStartDate;
    if (DateTime.now().weekday == DateTime.friday) {
      nextITPEndDate = DateTime.now().add(Duration(days: 9));
    }

    var nextITPStart = nextITPStartDate.day.toString() +
        '-' +
        nextITPStartDate.month.toString() +
        '-' +
        nextITPStartDate.year.toString();
    var nextITPEnd = nextITPEndDate.day.toString() +
        '-' +
        nextITPEndDate.month.toString() +
        '-' +
        nextITPEndDate.year.toString();
    DatabaseService databaseService = new DatabaseService();
    var customers =
        await databaseService.getCustomersForNextITP(nextITPStart, nextITPEnd);

    displaySnackBar(context, customers.length);

    customers.forEach((element) {
      send(element.nextITP, element.carPlates, element.phone);

      element.receivedSms = 1;
      databaseService.updateCustomer(element);
    });
  }

  Future<dynamic> send(String nextITP, String carPlates, String phone) async {
    var telephony = Telephony.instance;
    telephony.sendSms(
        to: phone,
        isMultipart: true,
        message: smsMessage
            .replaceFirst("{DATE}", nextITP)
            .replaceFirst("{CARPLATES}", carPlates));
    return null;
  }

  void displaySnackBar(BuildContext context, int smsNumber) {
    final snackBar =
        SnackBar(content: Text(S.of(context).snackBarMsg(smsNumber)));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
