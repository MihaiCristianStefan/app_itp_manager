import 'package:app_itp_manager/components/create_customer_modal/create_customer_modal.dart';
import 'package:app_itp_manager/generated/l10n.dart';
import 'package:app_itp_manager/models/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomersFilter extends StatefulWidget {
  final Function onAddNewCustomer;
  final Function onSearch;
  const CustomersFilter(
      {Key? key, required this.onAddNewCustomer, required this.onSearch})
      : super(key: key);

  @override
  State<CustomersFilter> createState() {
    return _CustomerFilterState(
        onAddNewCustomer: onAddNewCustomer, onSearch: onSearch);
  }
}

class _CustomerFilterState extends State<CustomersFilter> {
  final Function onAddNewCustomer;
  final Function onSearch;
  _CustomerFilterState(
      {required this.onAddNewCustomer, required this.onSearch});

  void onFormClose(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute<Customer>(
            builder: (context) => CreateCustomerModal(
                  customer: new Customer(
                      name: '',
                      phone: '',
                      carPlates: '',
                      lastITP: '',
                      nextITP: '',
                      receivedSms: 0),
                ),
            fullscreenDialog: true));
    onAddNewCustomer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(right: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: S.of(context).search,
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  onChanged: (String value) {
                    this.onSearch(value);
                  },
                ))),
        ElevatedButton.icon(
          onPressed: () {
            onFormClose(context);
          },
          icon: Icon(
            Icons.person_add_alt,
            color: Colors.white,
            size: 22.0,
          ),
          label: Text(S.of(context).createCustomer),
          style: ElevatedButton.styleFrom(
              primary: Colors.teal.shade600,
              textStyle: const TextStyle(fontSize: 16),
              fixedSize: Size(180, 80)),
        )
      ],
    );
  }
}
