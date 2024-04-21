import 'package:expense_app/data/data.dart';
import 'package:expense_app/widget/charts/chart.dart';
import 'package:expense_app/widget/expenses_list_items/expenses_list.dart';
import 'package:expense_app/widget/newexp.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  List<Expense> _exoenses_registered = [];

  void getdatafromdb() async {
    _exoenses_registered = await getdata();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getdatafromdb();
  }

  void openaddexpense() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (ctx) => New_exp(addExpense),
    );
  }

  void addExpense(Expense exp) {
    adddata(exp);
    setState(() {
      _exoenses_registered.add(exp);
    });
  }

  void remove_expense(Expense exp) {
    final index = _exoenses_registered.indexOf(exp);
    deleteexp(exp.id);
    setState(() {
      _exoenses_registered.remove(exp);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              adddata(exp);
              setState(() {
                _exoenses_registered.insert(index, exp);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitna Pesa Udaya"),
        actions: [
          IconButton(onPressed: openaddexpense, icon: const Icon(Icons.add_box))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _exoenses_registered),
                Expanded(
                    child: ExpensesList(
                  explist: _exoenses_registered,
                  remove_exp: remove_expense,
                ))
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _exoenses_registered)),
                Expanded(
                    child: ExpensesList(
                  explist: _exoenses_registered,
                  remove_exp: remove_expense,
                ))
              ],
            ),
    );
  }
}
