class OrderModel {
  final int? id;
  final String customerName;
  final String drinkType;
  final String instructions;
  final bool isCompleted;

  OrderModel({
    this.id,
    required this.customerName,
    required this.drinkType,
    required this.instructions,
    this.isCompleted = false,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      customerName: map['customerName'],
      drinkType: map['drinkType'],
      instructions: map['instructions'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'drinkType': drinkType,
      'instructions': instructions,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
