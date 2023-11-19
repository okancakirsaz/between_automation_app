class MenuItemModel {
  String? name;
  List<int>? img;
  List? materials;
  int? price;

  MenuItemModel({
    this.name,
    this.img,
    this.materials,
    this.price,
  });

  MenuItemModel copyWith({
    String? name,
    List<int>? img,
    List? materials,
    int? price,
  }) {
    return MenuItemModel(
      name: name ?? this.name,
      img: img ?? this.img,
      materials: materials ?? this.materials,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'img': img,
      'materials': materials,
      'price': price,
    };
  }

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      name: json['name'] as String?,
      img: (json['img'] as List<dynamic>?)?.map((e) => e as int).toList(),
      materials: (json['materials'] as List<dynamic>?)?.map((e) => e).toList(),
      price: json['price'] as int?,
    );
  }

  @override
  String toString() =>
      "MenuItemModel(name: $name,materials: $materials,price: $price,img: $img)";

  @override
  int get hashCode => Object.hash(name, img, materials, price);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          img == other.img &&
          materials == other.materials &&
          price == other.price;
}
