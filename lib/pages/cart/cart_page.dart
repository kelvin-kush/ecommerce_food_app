import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/icon.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: Dimensions.height20 * 2,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //  Navigator.pop(context);
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    //  size: Dimensions.font20,
                    backhroundColor: AppColor.appMainColor,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 3),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backhroundColor: AppColor.appMainColor,
                  ),
                ),
                // AppIcon(
                //   icon: Icons.shopping_cart,
                //   iconColor: Colors.white,
                //   backhroundColor: AppColor.appMainColor,
                // )
              ],
            )),
        Positioned(
            top: Dimensions.height20 * 4,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                // color: Colors.red,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    var cartList = cartController.getItems;

                    return cartController.getItems.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              // Image.asset(
                              //   'assets/images/empty.webp',
                              // ),
                              Lottie.asset('assets/images/cart.json'),
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              // Text(
                              //   'Please add items to cart',
                              //   style: TextStyle(
                              //       color: AppColor.appMainColor,
                              //       fontSize: Dimensions.font26),
                              //),
                            ],
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(top: 2),
                            itemCount: cartList.length,
                            itemBuilder: ((context, index) {
                              return Slidable(
                                actionExtentRatio: 0.25,
                                actionPane: const SlidableBehindActionPane(),
                                secondaryActions: [
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () {
                                      cartController
                                          .removeCartItem(cartList[index]);
                                    },
                                  )
                                ],
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: Dimensions.height100,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex =
                                              Get.find<PopProdController>()
                                                  .popProductList
                                                  .indexOf(
                                                      cartList[index].product!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(RouteHelper.getPopFoods(
                                                popularIndex, 'cartPage'));
                                          } else {
                                            var recomIndex = Get.find<
                                                    RecommendedProdController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    cartList[index].product!);
                                            Get.toNamed(RouteHelper.getRecFoods(
                                                recomIndex, 'cartPage'));
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          height: Dimensions.height100,
                                          width: Dimensions.width10 * 10,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPlOAD_URL +
                                                      cartController
                                                          .getItems[index]
                                                          .img!),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: Dimensions.height100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  cartController
                                                      .getItems[index].name!,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                // IconButton(
                                                //   color: Colors.red,
                                                //   icon:
                                                //       const Icon(Icons.delete),
                                                //   onPressed: () {
                                                //     cartController
                                                //         .removeCartItem(
                                                //             cartList[index]);
                                                //   },
                                                // )
                                              ],
                                            ),
                                            const Text(
                                              'Cake and fries',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '\$${cartController.getItems[index].price!}'
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font15,
                                                      color: Colors.red),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .height20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: const Icon(
                                                              Icons.remove)),
                                                      Text(cartList[index]
                                                          .quantity
                                                          .toString()),
                                                      // Text(popProduct.inCarItems.toString()),
                                                      GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: const Icon(
                                                              Icons.add)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                  },
                )))
      ]),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartcontroller) {
          return Container(
              height: Dimensions.height100,
              padding: EdgeInsets.fromLTRB(Dimensions.width20,
                  Dimensions.height30, Dimensions.width20, Dimensions.height30),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(Dimensions.radius20 * 2),
              ),
              child: cartcontroller.getItems.isEmpty
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              // width: 100,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.height20),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Total: ',
                                      style: TextStyle(
                                        fontSize: Dimensions.font20,
                                      )),
                                  Text(
                                    '\$${cartcontroller.totalAmount.toString()}',
                                    style: TextStyle(
                                        fontSize: Dimensions.font20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.appMainColor,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLogedIn()) {
                                cartcontroller.addToCartHistoryList();
                                // cartcontroller.addToCart();
                              } else {
                                Get.toNamed(RouteHelper.getSignIn());
                              }
                            },
                            child: Text(
                              'Check out',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.bold),
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
