import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/food_page_body.dart';
import 'package:get/get.dart';

Widget buildPageItem(int index, ProductModel popProduct) {
  Matrix4 matrix = new Matrix4.identity();
  if (index == curPageValue.floor()) {
    var curScale = 1 - (curPageValue - index) * (1 - scaleFactor);
    var curTrans = height * (1 - curScale) / 2;
    matrix = Matrix4.diagonal3Values(1, curScale, 1)
      ..setTranslationRaw(0, curTrans, 0);
  } else if (index == curPageValue.floor() + 1) {
    var curScale = scaleFactor + (curPageValue - index + 1) * (1 - scaleFactor);
    var curTrans = height * (1 - curScale) / 2;
    matrix = Matrix4.diagonal3Values(1, curScale, 1);
    matrix = Matrix4.diagonal3Values(1, curScale, 1)
      ..setTranslationRaw(0, curTrans, 0);
  } else if (index == curPageValue.floor() - 1) {
    var curScale = 1 - (curPageValue - index) * (1 - scaleFactor);
    var curTrans = height * (1 - curScale) / 2;
    matrix = Matrix4.diagonal3Values(1, curScale, 1);
    matrix = Matrix4.diagonal3Values(1, curScale, 1)
      ..setTranslationRaw(0, curTrans, 0);
  } else {
    var curScale = 0.8;
    matrix = Matrix4.diagonal3Values(1, curScale, 1)
      ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
  }

  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopFoods(index, 'home'));
          },
          child:
              // CachedNetworkImage(
              //   height: Dimensions.pageViewContainer,
              //   imageUrl:
              //       '${AppConstants.BASE_URL}${AppConstants.UPlOAD_URL}${popProduct.img}',
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven ? Colors.yellow[200] : Colors.blue[200],
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    '${AppConstants.BASE_URL}${AppConstants.UPlOAD_URL}${popProduct.img}'),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Color(0xFFe8e8e8),
                    //   color: Colors.grey,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  )
                ]),
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(popProduct.name ?? ''),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: AppColor.appMainColor,
                                  )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ],
    ),
  );
}
