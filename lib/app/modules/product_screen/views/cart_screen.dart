import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphy_task/app/global/widgets/custom_text.dart';
import 'package:graphy_task/app/modules/product_screen/controllers/product_controller.dart';
import 'package:graphy_task/app/utils/app_colors.dart';
import 'package:graphy_task/app/utils/app_strings.dart';

class CartScreen extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

   CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.shoppingCart,
          color: AppColors.blackDeep,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),),

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

              ///============================Total Button===============
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      text:
                      'Total: \$${controller.totalPrice.value}',

                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
