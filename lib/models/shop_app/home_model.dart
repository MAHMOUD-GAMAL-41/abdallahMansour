class HomeModel {
  late bool Status;
  late HomeDataModel data;

  HomeModel.FromJson(Map<String, dynamic> json) {
    Status = json['status'];
    data = HomeDataModel.FromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModels> banners = [];
  List<ProductModels> products = [];

  HomeDataModel.FromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModels.FromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModels.FromJson(element));
    });
  }
}

class BannerModels {
  late  int id;
  late   String image;

  BannerModels.FromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModels {
  late int id;
  late dynamic price, old_price, discount;
  late String image, name;
  late bool inFavorites, inCart;

  ProductModels.FromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    inCart = json['in_cart'];
    inFavorites = json['in_favorites'];
  }
}
