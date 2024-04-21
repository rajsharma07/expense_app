import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final fmt = DateFormat.yMd();

const uuid = Uuid();

enum Category { travel, food, stationary, others }

const categoryIcons = {
  Category.food: Icons.food_bank,
  Category.travel: Icons.electric_rickshaw,
  Category.stationary: Icons.book,
  Category.others: Icons.movie
};

class Expense {
  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Category category;
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      String? i})
      : id = i != null ? i : uuid.v4();
  String get formetdate {
    return fmt.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> explist;
  ExpenseBucket({required this.category, required this.explist});
  ExpenseBucket.forcategory(List<Expense> allexp, this.category)
      : explist =
            allexp.where((element) => element.category == category).toList();
  double get totaleexp {
    double sum = 0;
    for (final exp in explist) {
      sum += exp.amount;
    }
    return sum;
  }
}
