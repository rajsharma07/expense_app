import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItems extends StatelessWidget {
  const ExpensesItems(this.exp, {super.key});
  final Expense exp;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exp.title),
            const SizedBox(height: 20,),
            Row(
              children: [
                Text('Rs.${exp.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[exp.category]),
                    const SizedBox(width: 5,),
                    Text(exp.formetdate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
