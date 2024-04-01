class InputModel {
  String id;
  String title;
  double amount;
  DateTime dateTime;
  String description;

  InputModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.description,
  });

  // Convert InputModel object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'dateTime': dateTime.toIso8601String(),
      'description': description,
    };
  }

  // Create InputModel object from JSON data
  factory InputModel.fromJson(Map<String, dynamic> json) {
    return InputModel(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      dateTime: DateTime.parse(json['dateTime']),
      description: json['description'],
    );
  }
}
