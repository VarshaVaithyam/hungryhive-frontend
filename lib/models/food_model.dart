class FoodModel {
  final String id;
  final String donorName;
  final String organization;
  final String phoneNumber;
  final String location;
  final String foodName;
  final String quantity;
  final String description;
  final String status;
  final String ownerUserId;

  FoodModel({
    required this.id,
    required this.donorName,
    required this.organization,
    required this.phoneNumber,
    required this.location,
    required this.foodName,
    required this.quantity,
    required this.description,
    required this.status,
    required this.ownerUserId,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id']?.toString() ?? '',
      donorName: json['donorName']?.toString() ?? '',
      organization: json['organization']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      foodName: json['foodName']?.toString() ?? '',
      quantity: json['quantity']?.toString() ?? '',
      description: json['description']?.toString().trim() ?? '',
      status: json['status']?.toString() ?? '',
      ownerUserId: json['ownerUserId']?.toString() ?? '',
    );
  }
}