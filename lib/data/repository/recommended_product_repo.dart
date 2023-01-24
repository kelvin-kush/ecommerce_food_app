import 'package:food_app/data/api/api.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProdRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProdRepo({required this.apiClient});

  Future<Response> getRecommendedProdList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
