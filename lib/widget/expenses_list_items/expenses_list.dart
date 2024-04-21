import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widget/expenses_list_items/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.explist, required this.remove_exp});
  final void Function(Expense exp) remove_exp;
  final List<Expense> explist;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: explist.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(color: Colors.blueGrey.withOpacity(0.12)),
        key: ValueKey(explist[index]),
        onDismissed: (direction){
          remove_exp(explist[index]);
        },
        child: ExpensesItems(explist[index]),
      ),
    );
  }
}
