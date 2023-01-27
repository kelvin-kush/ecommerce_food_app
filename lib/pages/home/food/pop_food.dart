import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/expandableText.dart';
import 'package:food_app/widgets/icon.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                                  backhroundColor: AppColor.appMainColor),
                              // ),
                            )
                          : Container(),
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 6,
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
                    Text(product.name!,
                        style: GoogleFonts.poppins(
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              product.stars!,
                              (index) => Icon(
                                    Icons.star,
                                    color: AppColor.appMainColor,
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                          fontSize: Dimensions.font15,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: product.description!),
                      ),
                    )
                  ]),
            )),
      ]),
     
      bottomNavigationBar: GetBuilder<PopProdController>(builder: (popProduct) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30))),
          child: Column(
            
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
              
              SizedBox(
                height: Dimensions.height10,
              ),
              Row(
               
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('  Num of plates : ',
                              style: TextStyle(fontSize: Dimensions.font20)),
                         
                          Container(
                          
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
                                      popProduct.setQuantity(false);
                                    },
                                    child: const Icon(Icons.remove)),
                                Text(
                                  popProduct.inCarItems.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font20),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      popProduct.setQuantity(true);
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
             
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      popProduct.addItem(product);
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
