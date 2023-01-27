import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/data/api/api.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/icon.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/expandableText.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int listId;
  final String page;
  const RecommendedFoodDetail(
      {super.key, required this.listId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProdController>().recommendedProductList[listId];
    Get.find<RecommendedProdController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              automaticallyImplyLeading: false,
              //toolbarHeight: 80,
              title: Row(
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
                      child: AppIcon(icon: Icons.close)),
                  GetBuilder<RecommendedProdController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: Dimensions.height20,
                                    iconColor: Colors.transparent,
                                    backhroundColor: AppColor.appMainColor,
                                  ),
                                )
                              : Container(),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 5,
                                  top: 1,
                                  child: Text(
                                    '${Get.find<RecommendedProdController>().totalItems}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ))
                              : Container(),
                        ],
                      ),
                    );
                  }),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              Dimensions.height20,
                            ),
                            topRight: Radius.circular(
                              Dimensions.height20,
                            ))),
                    padding: EdgeInsets.only(
                        top: Dimensions.height5, bottom: Dimensions.height10),
                    width: double.maxFinite,
                    child: Center(
                        child: Text(
                      product.name!,
                      style: GoogleFonts.poppins(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.w500,
                          color: AppColor.appMainColor),
                    ))),
              ),
              backgroundColor: Colors.green[100],
              pinned: true,
              //floating: true,
              expandedHeight: Dimensions.height300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.UPlOAD_URL +
                      product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              )),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                        fontSize: Dimensions.font15,
                        fontWeight: FontWeight.w600),
                  ),
                  ExpandableText(
                    text: product.description!,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<RecommendedProdController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30))),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Dimensions.height10,
              ),
              RichText(
                text: TextSpan(
                    text: '  Price per plate: ',
                    style: TextStyle(
                        fontSize: Dimensions.font20, color: Colors.black),
                    children: [
                      TextSpan(
                        text: '\$${product.price}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font20),
                      ),
                    ]),
              ),
              //  Text('Price per plate: \$${product.price} ',
              //    style: TextStyle(fontSize: Dimensions.font20)),
              SizedBox(
                height: Dimensions.height10,
              ),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('  Num of plates : ',
                              style: TextStyle(fontSize: Dimensions.font20)),
                          // Icon(Icons.restaurant),
                          Container(
                            //  padding: EdgeInsets.all(10),
                            width: Dimensions.width10 * 8,
                            height: Dimensions.height30,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.setQuantity(false);
                                    },
                                    child: const Icon(Icons.remove)),
                                Text(
                                  controller.inCarItems.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font20),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      controller.setQuantity(true);
                                    },
                                    child: const Icon(Icons.add)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height15,
                      )
                    ],
                  ),
                ],
              ),
              // Container(
              //   padding: EdgeInsets.only(
              //       left: Dimensions.width20 * 2.5,
              //       right: Dimensions.width20 * 2.5,
              //       top: Dimensions.height10,
              //       bottom: Dimensions.height10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           controller.setQuantity(false);
              //         },
              //         child: AppIcon(
              //           iconColor: Colors.white,
              //           backhroundColor: Colors.green[100],
              //           icon: Icons.remove,
              //         ),
              //       ),
              //       Text(
              //         '\$ ${product.price} X ${controller.inCarItems}',
              //         style: TextStyle(fontSize: Dimensions.height20),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           controller.setQuantity(true);
              //         },
              //         child: AppIcon(
              //           icon: Icons.add,
              //           iconColor: Colors.white,
              //           backhroundColor: Colors.green[100],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //     height: Dimensions.height100,
              //     padding: EdgeInsets.fromLTRB(
              //         Dimensions.width20,
              //         Dimensions.height30,
              //         Dimensions.width20,
              //         Dimensions.height30),
              //     decoration: BoxDecoration(
              //       color: Colors.grey[100],
              //       borderRadius: BorderRadius.circular(Dimensions.radius20 * 2),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //             padding: EdgeInsets.all(12),
              //             decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.circular(15)),
              //             child: Icon(
              //               Icons.favorite,
              //               color: Colors.green[100],
              //             )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      // width: Dimensions.width10,
                      //  height: Dimensions.height45,
                      decoration: BoxDecoration(
                          color: AppColor.appMainColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        ' Add to cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width15,
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.height15,
              )
              //       ],
              //     )),
            ],
          ),
        );
      }),
    );
  }
}
