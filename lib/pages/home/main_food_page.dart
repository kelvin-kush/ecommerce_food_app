import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/food_page_body.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> loadResources() async {
    await Get.find<PopProdController>().getPopProdList();
    await Get.find<RecommendedProdController>().getRecommendedProdList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColor.appMainColor,
        //   automaticallyImplyLeading: false,
        //   title: Text(
        //     'Food App',
        //     style: GoogleFonts.poppins(
        //       fontSize: 20,
        //     ),
        //   ),
        //   actions: [
        //     // ),
        //     Container(
        //       width: 45,
        //       height: 45,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(15),
        //         color: AppColor.appMainColor,
        //       ),
        //       child: const Icon(Icons.search_rounded),
        //     ),
        //   ],
        // ),
        body: SafeArea(
      child: RefreshIndicator(
          onRefresh: loadResources,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 0),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     const Text('COuntry'),
                    //     Row(
                    //       children: const [
                    //         Text('Food'),
                    //         Icon(Icons.arrow_drop_down)
                    //       ],
                    //     ),
                    //   ],
                  ],
                ),
              ),
              const Expanded(
                  child: SingleChildScrollView(child: FoodPageBody())),
              SizedBox(
                height: Dimensions.height30,
              ),
            ],
          )),
    ));
  }
}
