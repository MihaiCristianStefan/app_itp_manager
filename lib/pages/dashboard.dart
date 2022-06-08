import 'package:app_itp_manager/components/customers_list/customers_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Main view of the application
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Include an Appbar
    // Display a list of the following ITPs
    return Scaffold(
      appBar: AppBar(
        title: Text('ITP Manager'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.white,
      body: CustomersList(),
    );
  }
}
