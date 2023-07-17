// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PercentageModel {
  int? percentage;
  PercentageModel({
    this.percentage,
  });

  PercentageModel copyWith({
    int? percentage,
  }) {
    return PercentageModel(
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'percentage': percentage,
    };
  }

  factory PercentageModel.fromMap(Map<String, dynamic> map) {
    return PercentageModel(
      percentage: map['percentage'] != null ? map['percentage'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PercentageModel.fromJson(String source) => PercentageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PercentageModel(percentage: $percentage)';

  @override
  bool operator ==(covariant PercentageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.percentage == percentage;
  }

  @override
  int get hashCode => percentage.hashCode;
}
