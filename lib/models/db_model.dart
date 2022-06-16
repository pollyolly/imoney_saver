// import 'package:imoney_saver/models/money_saver_arguments.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './money_saver_model.dart';

class DatabaseConnect {
  Database? _database; //_database variable is a nullable (can be null)

  Future<Database> get database async {
    final dbpath =
        await getDatabasesPath(); //location of db in device i.e. data/data //WidgetsFlutterBinding.ensureInitialized(); requirement
    const dbname = 'money_savers.db'; //db name
    final path =
        join(dbpath, dbname); //joining path i.e. data/data/money_saver.db

    _database = await openDatabase(path,
        version: 1, onCreate: _createDB); //open db connection

    return _database!; //! _database is nullable but we are sure that the returned value is not null
  }

//create our database
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE money_saver(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        remarks TEXT, 
        money REAL,
        category TEXT, 
        creationDate  TEXT,
        isChecked INTEGER
      );
    ''');
  }

  Future<void> insertData(MoneySaverModel data) async {
    final db = await database; //get connection to database
    await db.insert(
        'money_saver', data.toMap(), //toMap function in money_saver_model
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteAlldata() async {
    final db = await database;
    await db.delete('money_saver');
  }

  Future<void> deleteData(MoneySaverModel data) async {
    final db = await database;
    await db.delete('money_saver', where: 'id==?', whereArgs: [data.id]);
  }

  Future<List<MoneySaverModel>> getData() async {
    final db = await database;
    List<Map<String, dynamic>> items =
        await db.query('money_saver', orderBy: 'creationDate DESC');

    return List.generate(
        items.length,
        (i) => MoneySaverModel(
            id: items[i]['id'],
            remarks: items[i]['remarks'],
            money: items[i]['money'],
            // expenseMoney: items[i]['expenseMoney'],
            category: items[i]['category'],
            creationDate: DateTime.parse(items[i][
                'creationDate']), //text format from model convert to datetime format for display
            isChecked: items[i]['isChecked'] == 1 ? true : false));
  }
}
