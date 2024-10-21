import 'package:get/get.dart';
import 'package:graphy_task/app/data/models/product_model.dart';
import 'package:graphy_task/app/data/services/product_service.dart';

import 'package:hive/hive.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var cart = <Product>[].obs;
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      var box = await Hive.openBox('products');
      if (box.isEmpty) {
        List<Product> productsFromApi = await ProductService.fetchProducts();
        products.assignAll(productsFromApi);
        box.put('products', productsFromApi.map((e) => e.toJson()).toList());
      } else {
        var cachedProducts = box.get('products') as List<dynamic>;
        products.assignAll(cachedProducts.map((e) => Product.fromJson(e)));
      }
    } catch (e) {
      print(e);
    }
  }


  ///============================Add To Cart============================
  void addToCart(Product product) {
    cart.add(product);
    totalPrice.value += product.price;
  }

  ///============================Remove Cart ============================
  void removeFromCart(Product product) {
    cart.remove(product);
    totalPrice.value -= product.price;
  }
}
