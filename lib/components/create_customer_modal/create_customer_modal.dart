import 'package:app_itp_manager/components/create_customer_modal/create_customer_form.dart';
import 'package:app_itp_manager/generated/l10n.dart';
import 'package:app_itp_manager/models/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateCustomerModal extends StatelessWidget {
  final Customer customer;
  const CreateCustomerModal({Key? key, required this.customer})
      : super(key: key);

  void closeForm(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                customer.id > 0 ? S.of(context).editCustomer : S.of(context).createCustomer,
                style: TextStyle(fontSize: 20),
              ),
            ),
            IconButton(
                onPressed: () {
                  this.closeForm(context);
                },
                icon: Icon(Icons.close))
          ],
        ),
        CreateCustomerForm(
          customer: customer,
        )
      ],
    ));
  }
}
