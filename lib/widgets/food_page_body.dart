import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/loader.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/buildPageItem.dart';
import 'package:get/get.dart';

var curPageValue = 0.0;
double scaleFactor = 0.8;
double height = Dimensions.pageViewContainer;

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        curPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopProdController>(builder: (popularProducts) {
          return popularProducts.popProductList.isEmpty &&
                  !popularProducts.error
              ? CustomLoader(
                  //  color: Colors.green[100],
                  )
              : popularProducts.error
                  ? Text(popularProducts.errorMessage)
                  : SizedBox(
                      height: Dimensions.pageView,
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: popularProducts.popProductList.length,
                          itemBuilder: ((context, index) {
                            return buildPageItem(
                                index, popularProducts.popProductList[index]);
                          })),
                    );
        }),
        GetBuilder<PopProdController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popProductList.isEmpty
                ? 1
                : popularProducts.popProductList.length,
            position: curPageValue,
            decorator: DotsDecorator(
              activeColor:AppColor.appMainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Recommended',
                style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.appMainColor),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height15,
        ),
        GetBuilder<RecommendedProdController>(builder: (recommendedProducts) {
          return recommendedProducts.recommendedProductList.isEmpty &&
                  !recommendedProducts.error
              ? const Center(child: CustomLoader())
              : recommendedProducts.error
                  ? Text(recommendedProducts.errorMessage)
                  : SizedBox(
                      height: 700,
                      child: ListView.builder(
                          // shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              recommendedProducts.recommendedProductList.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    RouteHelper.getRecFoods(index, 'home'));
                              },
                              child: Row(
                                children: [
                                  // CachedNetworkImage(
                                  //   width: Dimensions.height120,
                                  //   height: Dimensions.height120,
                                  //   imageUrl:
                                  //       '${AppConstants.BASE_URL}${AppConstants.UPlOAD_URL}${recommendedProducts.recommendedProductList[index].img}',
                                  //   placeholder: (context, url) =>
                                  //       CircularProgressIndicator(),
                                  //   errorWidget: (context, url, error) =>
                                  //       Icon(Icons.error),
                                  // ),
                                  Container(
                                    width: Dimensions.height120,
                                    height: Dimensions.height120,
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10,
                                        left: Dimensions.width10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          '${AppConstants.BASE_URL}${AppConstants.UPlOAD_URL}${recommendedProducts.recommendedProductList[index].img}',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.radius20),
                                                bottomRight: Radius.circular(
                                                    Dimensions.radius20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${recommendedProducts.recommendedProductList[index].name}')
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            );
                          })),
                    );
        })
      ],
    );
  }
}
