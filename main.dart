import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'models/customer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomerListPage(),
    );
  }
}

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  List<Customer> customers = [];

  void loadCustomers() async {
    final list = await DatabaseHelper.instance.getCustomers();
    setState(() => customers = list);
  }

  @override
  void initState() {
    super.initState();
    loadCustomers();
  }

  void _addCustomer() async {
    final name = 'مشتری ${customers.length + 1}';
    final customer = Customer(name: name, balance: 0);
    await DatabaseHelper.instance.insertCustomer(customer);
    loadCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('دفتر احمد')),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final c = customers[index];
          return ListTile(
            title: Text(c.name),
            subtitle: Text('مانده حساب: ${c.balance.toStringAsFixed(0)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCustomer,
        child: Icon(Icons.add),
      ),
    );
  }
}

