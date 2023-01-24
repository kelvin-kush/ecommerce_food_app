import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/expandableText.dart';
import 'package:food_app/widgets/icon.dart';
import 'package:get/get.dart';

class PopFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    print('page id is' + pageId.toString());

    var product = Get.find<PopProdController>().popProductList[pageId];
    Get.find<PopProdController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: Dimensions.height300,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(AppConstants.BASE_URL +
                    AppConstants.UPlOAD_URL +
                    product.img!),
              ),
            ),
          ),
        ),
        Positioned(
          top: Dimensions.height30,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    if (page == 'cartPage') {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.arrow_back)),
              GetBuilder<PopProdController>(builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: Stack(
                    children: [
                      const AppIcon(icon: Icons.shopping_cart),
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,

                              child: AppIcon(
                                icon: Icons.circle,
                                size: Dimensions.height20,
                                iconColor: Colors.transparent,
                                backhroundColor: Colors.green[100],
                              ),
                              // ),
                            )
                          : Container(),
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 5,
                              top: 3,
                              child: Text(
                                '${Get.find<PopProdController>().totalItems}',
                                style: const TextStyle(color: Colors.white),
                              ))
                          : Container(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: Dimensions.height300 - Dimensions.height20,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name!),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: Colors.green[100],
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    const Text('Introduce'),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: product.description!),
                      ),
                    )
                  ]),
            )),
      ]),
      bottomNavigationBar: GetBuilder<PopProdController>(
        builder: (popProduct) {
          return Container(
              height: Dimensions.height100,
              padding: EdgeInsets.fromLTRB(Dimensions.width20,
                  Dimensions.height30, Dimensions.width20, Dimensions.height30),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(Dimensions.radius20 * 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //  padding: EdgeInsets.all(10),
                    width: 100,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height20),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              popProduct.setQuantity(false);
                            },
                            child: const Icon(Icons.remove)),
                        Text(popProduct.inCarItems.toString()),
                        GestureDetector(
                            onTap: () {
                              popProduct.setQuantity(true);
                            },
                            child: const Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[100],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        popProduct.addItem(product);
                      },
                      child: Text(
                        '\$${product.price} | Add to cart',
                        style: TextStyle(
                            color: Colors.white, fontSize: Dimensions.font20),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
