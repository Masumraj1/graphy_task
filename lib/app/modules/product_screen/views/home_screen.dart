import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphy_task/app/modules/product_screen/controllers/home_controller.dart';
import 'package:graphy_task/app/modules/product_screen/views/cart_screen.dart';

class HomeScreen  extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Catalog"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(CartScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ListTile(
                leading: Image.network(product.image, width: 50, height: 50),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    controller.addToCart(product);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}