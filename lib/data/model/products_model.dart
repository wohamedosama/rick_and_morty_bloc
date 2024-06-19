class ProductModel {
  int? id;
  String? categoryName;
  String? produtPicture;
  String? name;
  double? price;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    categoryName = json['categoryName'];
  }
}
