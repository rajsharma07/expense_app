import 'package:expense_app/models/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void adddata(Expense e) async {
  var databasepath = await getDatabasesPath();
  var path = join(databasepath, "expense.db");
  Database db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async{
      await db.execute(
          'CREATE TABLE expensedata (id TEXT PRIMARY KEY, title TEXT, date TEXT, amount REAL, category TEXT)');
    },
  );
  await db.insert('expensedata', {
    "id": e.id,
    "title": e.title,
    "date": e.formetdate,
    "amount": e.amount,
    "category": e.category.toString()
  });
}

void deleteexp(String id)async{
  var databasepath = await getDatabasesPath();
  var path = join(databasepath, "expense.db");
  Database db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async{
     await db.execute(
          'CREATE TABLE expensedata (id TEXT PRIMARY KEY, title TEXT, date TEXT, amount REAL, category TEXT)');
    },
  );
  await db.delete('expensedata',where: 'id = ?', whereArgs: [id]);
}

Future<List<Expense>> getdata() async {
  var databasepath = await getDatabasesPath();
  var path = join(databasepath, "expense.db");
  print(path);
  Database db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async{
      await db.execute(
          'CREATE TABLE expensedata (id TEXT PRIMARY KEY, title TEXT, date TEXT, amount REAL, category TEXT)');
    },
  );

  List<Map<String, dynamic>> expdata = await db.query('expensedata');
  if(expdata.isNotEmpty){
  var exps = expdata.map(
    (e) {
      Category c = Category.others;
      if (e['category'] == "Category.food") {
        c = Category.food;
      } else if (e['category'] == "Category.others") {
        c = Category.others;
      } else if (e['category'] == "Category.stationary") {
        c = Category.stationary;
      } else if (e['category'] == "Category.travel") {
        c = Category.travel;
      }
      print(e['title']);
      print(e['category']);
      return Expense(
          title: e['title'] as String,
          amount: e['amount'] as double,
          date: fmt.parse(e['date'] as String),
          category: c,
          i: e['id']
          );
    },
    
  ).toList();

  return exps;
  }
  return [];
}
