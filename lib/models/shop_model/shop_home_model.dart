class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> jason) {
    status = jason['status'];
    data = HomeDataModel.fromJson(jason['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> jason) {
    jason['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });
    jason['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class ProductsModel {
  int? id;
  String? name;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  bool? in_favorites;
  bool? in_cart;

  ProductsModel.fromJson(Map<String, dynamic> jason) {
    id = jason['id'];
    name = jason['name'];
    price = jason['price'];
    old_price = jason['old_price'];
    discount = jason['discount'];
    image = jason['image'];
    in_favorites = jason['in_favorites'];
    in_cart = jason['in_cart'];
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> jason) {
    id = jason['id'];
    image = jason['image'];
  }
}
