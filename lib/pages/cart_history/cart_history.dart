import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/icon.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({super.key});

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  // @override
  // void initState() {
  //   super.initState();
  //   initgetHistory();
  // }

  // initgetHistory() async {
  //   await Get.find<CartController>().getCartHistoryList();
  // }

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().cartListHistory.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();
    var listCounter = 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.appMainColor,
        title: Text(
          'Cart History',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.find<CartController>().deleteAllCartHistory();
              },
              child: Text(
                'clear cart History',
                style: GoogleFonts.poppins(
                    color: Colors.red, fontSize: Dimensions.font15),
              ))
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   height: Dimensions.height100,
          //   color: AppColor.appMainColor,
          //   width: double.maxFinite,
          //   padding: EdgeInsets.only(top: Dimensions.height45),
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         const Text(
          //           'Cart History',
          //           style: TextStyle(color: Colors.white, fontSize: 24),
          //         ),
          //         AppIcon(
          //           icon: Icons.shopping_cart_outlined,
          //           iconColor: AppColor.appMainColor,
          //         )
          //       ]),
          // ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.cartListHistory.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/empty.webp',
                          //  color: AppColor.appMainColor,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      Text(
                        'Nothing bought yet',
                        style: TextStyle(
                            color: AppColor.appMainColor, fontSize: 23),
                      ),
                    ],
                  )
                : Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimensions.height150,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    (() {
                                      DateTime parseDate = DateFormat(
                                              'yyyy-MM-dd HH:mm:ss')
                                          .parse(getCartHistoryList[listCounter]
                                              .time!);
                                      var inputDate =
                                          DateTime.parse(parseDate.toString());
                                      var outputFormat =
                                          DateFormat('dd/MM//yyyy hh:mm a');
                                      var outputDate =
                                          outputFormat.format(inputDate);
                                      return Text(outputDate);
                                    }()),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height100,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Wrap(
                                                direction: Axis.horizontal,
                                                children: List.generate(
                                                    itemsPerOrder[i], (index) {
                                                  if (listCounter <
                                                      getCartHistoryList
                                                          .length) {
                                                    listCounter++;
                                                  }
                                                  return Container(
                                                    height:
                                                        Dimensions.height100,
                                                    width: Dimensions.height100,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .height10),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(AppConstants
                                                                .BASE_URL +
                                                            AppConstants
                                                                .UPlOAD_URL +
                                                            getCartHistoryList[
                                                                    listCounter -
                                                                        1]
                                                                .img!),
                                                      ),
                                                    ),
                                                    //  child: Text('Hi there'),
                                                  );
                                                })),
                                          ]),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Summary- ${itemsPerOrder[i].toString()} ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        itemsPerOrder[i] == 1
                                            ? const Text(
                                                'item',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : const Text(
                                                'items',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                        // GetBuilder<CartController>(
                                        //     builder: (cartcontroller) {
                                        //   return Text(
                                        //       'Total amount \$ ${cartcontroller.totalAmount.toString()}');
                                        // })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ]),
                        )));
          })
        ],
      ),
    );
  }
}
