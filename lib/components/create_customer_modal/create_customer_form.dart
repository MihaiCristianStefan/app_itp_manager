import 'package:app_itp_manager/generated/l10n.dart';
import 'package:app_itp_manager/models/customer.dart';
import 'package:app_itp_manager/services/database.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NextItp { HalfYear, OneYear, TwoYears }

class CreateCustomerForm extends StatefulWidget {
  final Customer customer;

  const CreateCustomerForm({Key? key, required this.customer})
      : super(key: key);

  @override
  State<CreateCustomerForm> createState() {
    return _CreateCustomerFormState(customer: this.customer);
  }
}

class _CreateCustomerFormState extends State<CreateCustomerForm> {
  final Customer customer;

  _CreateCustomerFormState({required this.customer});

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final carPlatesController = TextEditingController();
  final phoneController = TextEditingController();
  final nextItpController = TextEditingController();
  final lastItpController = TextEditingController();

  late DateTime lastItp = DateTime.now();

  NextItp? nextItp = NextItp.HalfYear;

  DatabaseService databaseService = new DatabaseService();

  InputDecoration _textFiledDecoration(String label) {
    return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14),
        border: OutlineInputBorder());
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (picked != null && picked != lastItp)
      setState(() {
        lastItp = picked;
        lastItpController.text = lastItp.day.toString() +
            '-' +
            lastItp.month.toString() +
            '-' +
            lastItp.year.toString();
      });
  }

  void closeForm(BuildContext context) {
    Navigator.pop(context);
  }

  void onCancel(BuildContext context) {
    closeForm(context);
  }

  void onDelete(BuildContext context) {
    databaseService.deleteCustomer(this.customer.id);
    closeForm(context);
  }

  void calculateNextITP() {
    lastItp = DateTime(
        int.parse(this.customer.lastITP.split('-')[2]),
        int.parse(this.customer.lastITP.split('-')[1]),
        int.parse(this.customer.lastITP.split('-')[0]));
    var nextItpDate = DateTime(
        int.parse(this.customer.nextITP.split('-')[2]),
        int.parse(this.customer.nextITP.split('-')[1]),
        int.parse(this.customer.nextITP.split('-')[0]));

    var diff = nextItpDate.difference(lastItp);

    switch (diff.inDays) {
      case 180:
        nextItp = NextItp.HalfYear;
        break;
      case 365:
        nextItp = NextItp.OneYear;
        break;
      default:
        nextItp = NextItp.TwoYears;
        break;
    }
  }

  @override
  void initState() {
    if (this.customer.id > 0) {
      this.nameController.text = this.customer.name;
      this.phoneController.text = this.customer.phone;
      this.carPlatesController.text = this.customer.carPlates;
      this.lastItpController.text = this.customer.lastITP;
      calculateNextITP();
    }

    super.initState();
  }

  void onSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    var nextItpDate = DateTime(int.parse(this.lastItpController.text.split('-')[2]),
                              int.parse(this.lastItpController.text.split('-')[1]),
                              int.parse(this.lastItpController.text.split('-')[0])).add(Duration(
        days: nextItp?.index == 0 ? 180 : (nextItp?.index == 1 ? 365 : 730)));

    Customer newCustomer = new Customer(
        name: nameController.text,
        phone: phoneController.text,
        carPlates: carPlatesController.text.toUpperCase(),
        lastITP: lastItpController.text,
        nextITP: nextItpDate.day.toString() +
            '-' +
            nextItpDate.month.toString() +
            '-' +
            nextItpDate.year.toString(),
        receivedSms: 0);

    if (this.customer.id > 0) {
      newCustomer.id = this.customer.id;
      var currentDate = DateTime.now().day.toString() +
          "-" +
          DateTime.now().month.toString() +
          "-" +
          DateTime.now().year.toString();
      if (newCustomer.lastITP.toString() == currentDate) {
        newCustomer.receivedSms = 0;
      }
      databaseService.updateCustomer(newCustomer);
    } else {
      databaseService.insertCustomer(newCustomer);
    }

    closeForm(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Expanded(
            child: SizedBox(
                width: 400,
                height: 900,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: _textFiledDecoration(S.of(context).name),
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 14),
                          labelText: S.of(context).phone,
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: carPlatesController,
                      decoration: _textFiledDecoration(S.of(context).carPlates),
                      validator: (String? value) {
                        var regex = RegExp('([A-Z]{1,2}[0-9]{2,3}[A-Z]{3})');
                        if (value != null && !regex.hasMatch(value)) {
                          return 'Incorrect format';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: lastItpController,
                      readOnly: true,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 14),
                          labelText: S.of(context).lastITP,
                          suffixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder()),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: 400,
                      child: Text(
                        S.of(context).nextITP,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                nextItp = NextItp.HalfYear;
                              });
                            },
                            child: Text(S.of(context).sixMonths,
                                textAlign: TextAlign.center),
                            style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 16),
                                fixedSize: Size(90, 70),
                                alignment: Alignment.center,
                                primary: nextItp == NextItp.HalfYear
                                    ? Colors.red
                                    : Colors.teal)),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                nextItp = NextItp.OneYear;
                              });
                            },
                            child: Text(S.of(context).oneYear,
                                textAlign: TextAlign.center),
                            style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 16),
                                fixedSize: Size(90, 70),
                                alignment: Alignment.center,
                                primary: nextItp == NextItp.OneYear
                                    ? Colors.red
                                    : Colors.teal)),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                nextItp = NextItp.TwoYears;
                              });
                            },
                            child: Text(S.of(context).twoYears,
                                textAlign: TextAlign.center),
                            style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 16),
                                fixedSize: Size(90, 70),
                                alignment: Alignment.center,
                                primary: nextItp == NextItp.TwoYears
                                    ? Colors.red
                                    : Colors.teal)),
                      ],
                    ),
                    Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    this.customer.id > 0
                                        ? ElevatedButton(
                                            onPressed: () {
                                              onDelete(context);
                                            },
                                            child: Text(S.of(context).delete),
                                            style: ElevatedButton.styleFrom(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                fixedSize: Size(100, 60),
                                                primary:
                                                    Colors.redAccent.shade400),
                                          )
                                        : ElevatedButton(
                                            onPressed: () {
                                              this.onCancel(context);
                                            },
                                            child: Text(S.of(context).cancel),
                                            style: ElevatedButton.styleFrom(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                fixedSize: Size(100, 60),
                                                primary:
                                                    Colors.redAccent.shade400),
                                          ),
                                    ElevatedButton(
                                        onPressed: () {
                                          this.onSave(context);
                                        },
                                        child: Text(S.of(context).save),
                                        style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          fixedSize: Size(100, 60),
                                        ))
                                  ],
                                ))))
                  ],
                ))));
  }
}
