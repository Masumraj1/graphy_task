import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphy_task/app/modules/product_screen/controllers/home_controller.dart';

class CartScreen extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

   CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      body: Obx(() {
        if (controller.cart.isEmpty) {
          return const Center(child: Text("Cart is Empty"));
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) {
                    final product = controller.cart[index];
                    return ListTile(
                      leading: Image.network(product.image, width: 50, height: 50),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          controller.removeFromCart(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: \$${controller.totalPrice.value}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
