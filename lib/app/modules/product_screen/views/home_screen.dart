import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphy_task/app/core/app_routes.dart';
import 'package:graphy_task/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:graphy_task/app/global/widgets/custom_text.dart';
import 'package:graphy_task/app/modules/product_screen/controllers/product_controller.dart';
import 'package:graphy_task/app/modules/product_screen/views/cart_screen.dart';
import 'package:graphy_task/app/utils/app_colors.dart';
import 'package:graphy_task/app/utils/app_strings.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController controller = Get.find<ProductController>();

  late Function(GlobalKey) runAddToCartAnimation; // Function for running animation
  final GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>(); // Key for cart icon

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
          Obx(() {
            return Stack(
              children: [
                AddToCartIcon(
                  key: cartKey, // Add key to the cart icon
                  icon: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.cartScreen);
                      },
                      child: const Icon(Icons.shopping_cart)),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${controller.cart.length}',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
                ),
              ],
            );
          }),
        ],
      ),
      body: AddToCartAnimation(
        cartKey: cartKey,
        height: 30,
        width: 30,
        opacity: 0.85,
        dragAnimation: DragToCartAnimationOptions(),
        jumpAnimation: JumpAnimationOptions(),
        createAddToCartAnimation: (runAnimation) {
          runAddToCartAnimation = runAnimation;
        },
        child: Obx(() {
          if (controller.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                final GlobalKey widgetKey = GlobalKey(); // Create a unique key for each product

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Image.network(product.image, width: 50, height: 50),
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
                          runAddToCartAnimation(widgetKey); // Trigger the add to cart animation
                          controller.addToCart(product); // Add product to cart
                        },
                      ),
                      key: widgetKey, // Key for each product's animation
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
