class SubscriptionModel {
  final String id;
  final String name;
  final double price;
  final String currency;
  final DateTime renewalDate;
  final String category;
  final bool isActive;
  final String iconUrl;

  SubscriptionModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.renewalDate,
    required this.category,
    required this.isActive,
    required this.iconUrl,
  });

  String get formattedRenewalDate => "${renewalDate.day}/${renewalDate.month}/${renewalDate.year}";
}