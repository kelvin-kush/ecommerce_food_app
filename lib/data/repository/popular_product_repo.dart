import 'package:food_app/data/api/api.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProdRepo extends GetxService {
  final ApiClient apiClient;

  PopularProdRepo({required this.apiClient});

  Future<Response> getPopularProdList() async {
    return await apiClient.getData(AppConstants.DRINKS_URI);
  }
}
