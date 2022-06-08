import 'package:app_itp_manager/components/create_customer_modal/create_customer_modal.dart';
import 'package:app_itp_manager/components/customers_filter/customers_filter.dart';
import 'package:app_itp_manager/generated/l10n.dart';
import 'package:app_itp_manager/models/customer.dart';
import 'package:app_itp_manager/services/database.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_itp_manager/services/sms.service.dart';

final List<Customer> customers = List.generate(
    0,
    (index) => Customer(
        name: '',
        phone: '',
        carPlates: '',
        lastITP: '',
        nextITP: '',
        receivedSms: 0));
final List<Customer> unfilteredCustomers = List.generate(
    0,
    (index) => Customer(
        name: '',
        phone: '',
        carPlates: '',
        lastITP: '',
        nextITP: '',
        receivedSms: 0));

class CustomersList extends StatefulWidget {
  const CustomersList({Key? key}) : super(key: key);

  @override
  State<CustomersList> createState() {
    return _CustomersListState();
  }
}

class _CustomersListState extends State<CustomersList> {
  bool inactiveSms = false;

  void fetchCustomers() async {
    DatabaseService databaseService = new DatabaseService();
    var _customers = await databaseService.getAllCustomers();
    setState(() {
      customers.clear();
      unfilteredCustomers.clear();
      _customers.forEach((element) {
        customers.add(element);
        unfilteredCustomers.add(element);
      });
    });
  }

  void addNewCustomer() {
    setState(() {
      this.fetchCustomers();
    });
  }

  void fetchByCarPlates(String carPlates) {
    customers.clear();
    setState(() {
      unfilteredCustomers.forEach((element) {
        if (element.carPlates.contains(carPlates.toUpperCase())) {
          customers.add(element);
        }
      });
    });
  }

  void smsSent() {
    var currentDateStart = DateTime.now().add(Duration(days: 7));
    var currentDateEnd = DateTime.now().weekday == DateTime.friday
        ? DateTime.now().add(Duration(days: 9))
        : currentDateStart;
    var defaultInactive = DateTime.now().weekday == DateTime.saturday ||
        DateTime.now().weekday == DateTime.sunday;

    var currentDateStartFormated = currentDateStart.day.toString() +
        '-' +
        currentDateStart.month.toString() +
        '-' +
        currentDateStart.year.toString();

    var currentDateEndFormated = currentDateEnd.day.toString() +
        '-' +
        currentDateEnd.month.toString() +
        '-' +
        currentDateEnd.year.toString();
    setState(() {
      inactiveSms = customers
                  .map((e) =>
                      e.receivedSms == 0 &&
                      DateTime.parse(e.nextITP).compareTo(
                              DateTime.parse(currentDateStartFormated)) >=
                          0 &&
                      DateTime.parse(e.nextITP).compareTo(
                              DateTime.parse(currentDateEndFormated)) <=
                          0)
                  .toList()
                  .length >
              0 ||
          defaultInactive;
    });
  }

  Future<bool> areCustomersWithNextITP() async {
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

    return customers.length > 0;
  }

  @override
  void initState() {
    fetchCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 500.0),
                width: 500.0,
                height: 40,
                child: CustomersFilter(
                  onAddNewCustomer: addNewCustomer,
                  onSearch: fetchByCarPlates,
                ),
                margin: EdgeInsets.only(bottom: 5),
              ),
              Expanded(
                  child: Container(
                width: 500.0,
                height: MediaQuery.of(context).size.height - 100,
                child: _customScrollView(),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
                color: Colors.white,
              )),
              ElevatedButton(
                onPressed: () {
                  if (!inactiveSms) {
                    new SmsService().sendSMS(context);
                  }
                },
                child: Text(
                  S.of(context).sendSMS,
                  style: TextStyle(fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(500, 40),
                    primary: !inactiveSms ? Colors.blue : Colors.grey),
              )
            ],
          ),
        ),
      ]),
    );
  }

  void updateUser(BuildContext context, int index) async {
    await Navigator.push(
        context,
        MaterialPageRoute<Customer>(
            builder: (context) =>
                CreateCustomerModal(customer: customers[index]),
            fullscreenDialog: true));
    fetchCustomers();
  }

  Widget _customScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return InkWell(
              child: Container(
                constraints: BoxConstraints(maxWidth: 500, maxHeight: 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ],
                ),
                padding: const EdgeInsets.only(
                    left: 21, right: 13, top: 5, bottom: 5),
                margin: EdgeInsets.only(
                    bottom: 10, left: 5, right: 5, top: _isFirstElement(index)),
                child: _customScrollViewItem(index),
              ),
              onTap: () {
                updateUser(context, index);
              },
            );
          }, childCount: customers.length),
        )
      ],
    );
  }

  double _isFirstElement(int index) {
    return index == 0 ? 5 : 0;
  }

  Widget _customScrollViewItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${customers[index].name} - ${customers[index].carPlates} - ${customers[index].nextITP}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Color.fromARGB(255, 112, 112, 112)),
            ),
            Text(
              "${customers[index].phone}\n${customers[index].lastITP}",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Color.fromARGB(255, 112, 112, 112)),
            ),
          ],
        ),
      ],
    );
  }
}
