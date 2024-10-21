import 'package:get/get.dart';
import 'package:graphy_task/app/data/models/product_model.dart';
import 'package:graphy_task/app/data/services/product_service.dart';
import 'package:hive/hive.dart';


enum Status { loading, success, error }

class ProductController extends GetxController {
  // Status to track API request
  final rxRequestStatus = Status.loading.obs;

  // Method to update request status
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  // List to store products and cart items
  var products = <Product>[].obs;
  var cart = <Product>[].obs;

  // Total price for items in the cart
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Fetch products when controller initializes
  }

  // Method to fetch products from API or cache
  Future<void> fetchProducts() async {
    setRxRequestStatus(Status.loading); // Set loading status
    try {
      var box = Hive.box('products'); // Access Hive box

      if (box.isEmpty) {
        // Fetch from API if no cache
        List<Product> productsFromApi = await ProductService.fetchProducts();
        products.assignAll(productsFromApi);

        // Save products to Hive
        await box.put('products', productsFromApi);
      } else {
        // Load from cache if available
        List<Product> cachedProducts = box.get('products').cast<Product>();
        products.assignAll(cachedProducts);
      }

      setRxRequestStatus(Status.success); // Set success status
    } catch (e) {
      print('Error fetching products: $e');
      setRxRequestStatus(Status.error); // Set error status if something goes wrong
    }
  }

  // Method to add products to the cart
  void addToCart(Product product) {
    cart.add(product);
    totalPrice.value += product.price;
  }

  // Method to remove products from the cart
  void removeFromCart(Product product) {
    cart.remove(product);
    totalPrice.value -= product.price;
  }
}
