import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphy_task/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:graphy_task/app/global/widgets/custom_text.dart';
import 'package:graphy_task/app/modules/product_screen/controllers/product_controller.dart';
import 'package:graphy_task/app/modules/product_screen/views/cart_screen.dart';
import 'package:graphy_task/app/utils/app_colors.dart';
import 'package:graphy_task/app/utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      drawer: const Drawer(),

      ///================================All Product Appbar==============
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.allProduct,
          color: AppColors.blackDeep,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
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
          return const Center(child: CustomLoader());
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading:
                        Image.network(product.image, width: 50, height: 50),
                    title: CustomText(
                      text: product.title,
                      color: AppColors.blackDeep,
                      fontSize: 14,
                      maxLines: 3,
                      bottom: 8,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,
                    ),
                    subtitle: CustomText(
                      textAlign: TextAlign.start,
                      text: '\$${product.price}',
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        controller.addToCart(product);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
