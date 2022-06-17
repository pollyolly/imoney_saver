class MoneySaverModel {
  int? id;
  final String remarks;
  final num money;
  // final double incomeMoney;
  // final double expenseMoney;
  final String category;
  final DateTime creationDate;
  final bool isChecked;

//Constructor
  MoneySaverModel(
      {this.id,
      required this.remarks,
      required this.money,
      // required this.incomeMoney,
      // required this.expenseMoney,
      required this.category,
      required this.creationDate,
      required this.isChecked});

  //to save data in DB need to convert using Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'remarks': remarks,
      'creationDate':
          creationDate.toString(), //sqflite does not support datetime data type
      'money': money,
      // 'incomeMoney': incomeMoney,
      // 'expenseMoney': expenseMoney,
      'category': category,
      'isChecked': isChecked ? 1 : 0 //sqflite does not support boolean
    };
  }

  //For Debugging //Checking
  @override
  String toString() {
    return 'id $id, remarks: $remarks, creationDate: $creationDate, money: $money, category: $category,isChecked: $isChecked';
  }
}
