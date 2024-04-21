// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class New_exp extends StatefulWidget {
  const New_exp(this.onadd, {super.key});
  final Function(Expense exp) onadd;

  @override
  State<StatefulWidget> createState() {
    return _New_exp();
  }
}

class _New_exp extends State<New_exp> {
  final textedtcont = TextEditingController();
  final amountcontroler = TextEditingController();
  Category selectedcategory = Category.others;
  DateTime? selecteddate;
  void presentdatepicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    await showDatePicker(
      context: context,
      firstDate: first,
      lastDate: now,
    ).then((value) {
      setState(() {
        selecteddate = value;
      });
    });
  }

  void _subitedexpense() {
    final enteredamount = double.tryParse(amountcontroler.text);
    bool amountvalid = enteredamount == null || enteredamount < 0;
    if (textedtcont.text.trim().isEmpty ||
        amountvalid ||
        selecteddate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('enter valid values'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okey'),
            )
          ],
        ),
      );
    } else {
      widget.onadd(
        Expense(
            title: textedtcont.text,
            amount: double.parse(amountcontroler.text),
            date: selecteddate!,
            category: selectedcategory),
      );
      Navigator.pop(context);
    }
    return;
  }

  @override
  void dispose() {
    textedtcont.dispose();
    amountcontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 50,
                          controller: textedtcont,
                          decoration: const InputDecoration(
                            label: Text("Title of Expense: "),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: amountcontroler,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('Amount'), prefix: Text('Rs.')),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    maxLength: 50,
                    controller: textedtcont,
                    decoration: const InputDecoration(
                      label: Text("Title of Expense: "),
                    ),
                  ),
                Row(
                  children: [
                    if (width >= 600)
                      DropdownButton(
                          value: selectedcategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedcategory = value;
                            });
                          })
                    else
                      Expanded(
                        child: TextField(
                          controller: amountcontroler,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('Amount'), prefix: Text('Rs.')),
                        ),
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(selecteddate == null
                              ? 'No date selected'
                              : fmt.format(selecteddate!)),
                          IconButton(
                              onPressed: presentdatepicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancle'),
                    ),
                    ElevatedButton(
                      onPressed: _subitedexpense,
                      child: const Text("Submit"),
                    ),
                    const Spacer(),
                    if (width < 600)
                      DropdownButton(
                          value: selectedcategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedcategory = value;
                            });
                          })
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
