import 'package:app_itp_manager/models/customer.dart';
import 'package:app_itp_manager/models/sms.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? database;
  Future<List<Customer>> getAllCustomers() async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'itp_manager.db'));

    final List<Map<String, dynamic>> result = await db.query('customers', orderBy: 'id DESC' );

    db.close();

    return List.generate(result.length, (i) {
      return Customer(
          id: result[i]['id'],
          name: result[i]['name'],
          phone: result[i]['phone'],
          carPlates: result[i]['carPlates'],
          lastITP: result[i]['lastITP'],
          nextITP: result[i]['nextITP'],
          receivedSms: result[i]['receivedSms']);
    });
  }

  Future<List<Customer>> getCustomersForNextITP(
      String start, String end) async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'itp_manager.db'));

    final List<Map<String, dynamic>> result = await db.query('customers',
        where: 'CAST(nextITP AS DATE) >= CAST( ? AS DATE) AND CAST(nextITP AS DATE) <= CAST( ? AS DATE) AND receivedSms != 1', whereArgs: [start, end]);
    db.close();

    return List.generate(result.length, (i) {
      return Customer(
          id: result[i]['id'],
          name: result[i]['name'],
          phone: result[i]['phone'],
          carPlates: result[i]['carPlates'],
          lastITP: result[i]['lastITP'],
          nextITP: result[i]['nextITP'],
          receivedSms: result[i]['receivedSms']);
    });
  }

  Future<void> insertCustomer(Customer customer) async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'itp_manager.db'));

    await db.insert('customers', customer.toMap());
  }

  Future<void> updateCustomer(Customer customer) async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'itp_manager.db'));

    await db.update('customers', customer.toMap(),
        where: 'id = ?', whereArgs: [customer.id]);
  }

  Future<void> deleteCustomer(int id) async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'itp_manager.db'));

    await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertSMS(SmsModel smsModel) async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'itp_manager.db'));

    await db.insert('sms_sent', smsModel.toMap());
  }
}
