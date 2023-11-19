class InventoryElementModel {
  String? name;
  int? cost;
  int? count;
  String? unit;
  String? currency;
  int? prefferedCount;

  InventoryElementModel({
    this.name,
    this.cost,
    this.count,
    this.unit,
    this.currency,
    this.prefferedCount,
  });

  InventoryElementModel copyWith({
    String? name,
    int? cost,
    int? count,
    String? unit,
    String? currency,
    int? prefferedCount,
  }) {
    return InventoryElementModel(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      count: count ?? this.count,
      unit: unit ?? this.unit,
      currency: currency ?? this.currency,
      prefferedCount: prefferedCount ?? this.prefferedCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'unit': unit,
      'count': count,
      'currency': currency,
      'prefferedCount': prefferedCount,
    };
  }

  factory InventoryElementModel.fromJson(Map<String, dynamic> json) {
    return InventoryElementModel(
      name: json['name'] as String?,
      cost: json['cost'] as int?,
      count: json['count'] as int?,
      unit: json['unit'] as String?,
      currency: json['currency'] as String?,
      prefferedCount: json['prefferedCount'] as int?,
    );
  }

  @override
  String toString() =>
      "InventoryElementModel(name: $name,cost: $cost,unit: $unit,currency: $currency,prefferedCount: $prefferedCount)";

  @override
  int get hashCode => Object.hash(name, cost, unit, currency, prefferedCount);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryElementModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          cost == other.cost &&
          unit == other.unit &&
          currency == other.currency &&
          prefferedCount == other.prefferedCount;
}
