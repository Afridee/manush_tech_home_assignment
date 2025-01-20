
import 'promotionDetail.dart';

class Promotion {
  final int id;
  final DateTime createdAt;
  final String title;
  final String type;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<PromotionDetail> promotionDetails;

  Promotion({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.type,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.promotionDetails,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
    id: json['id'],
    createdAt: DateTime.parse(json['createdAt']),
    title: json['title'],
    type: json['type'],
    description: json['description'],
    startDate: DateTime.parse(json['startDate']),
    endDate: DateTime.parse(json['endDate']),
    promotionDetails: List<PromotionDetail>.from(json['promotionDetails'].map((x) => PromotionDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'title': title,
    'type': type,
    'description': description,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'promotionDetails': List<dynamic>.from(promotionDetails.map((x) => x.toJson())),
  };
}