import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/gold_model.dart';
import 'package:dio/dio.dart';

final apiServiceProvider = Provider<ApiServices>((ref) => ApiServices());

class ApiServices {
  GoldModel data = GoldModel();
  final dio = Dio();

  Future<GoldModel> getProduct(
      String code, String branch, String designCode) async {
    print('object');
    print(code);
    print(branch);
    print('branch');
    try {
      String endPoint = code != ''
          ? 'http://viewproduct-env.eba-smbpywd9.ap-south-1.elasticbeanstalk.com/api/productInfoes/$code/0/$branch'
          : 'http://viewproduct-env.eba-smbpywd9.ap-south-1.elasticbeanstalk.com/api/productInfoes/0/$designCode/$branch';
      print(endPoint);
      print("endPoint");

      final response = await dio.get(endPoint);

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return GoldModel.fromJson(jsonResponse[0]);
      } else {
        throw Exception(' ------SELECT A VALID CODE------');
      }
    } catch (e) {
      throw Exception(
          ' --- GIVE A VALID CODE AND BRANCH \n ProductCode$code  branch $branch designCode=$designCode--- ');
    }
  }

  // Future<String> getProductImage() async {
  //   try {
  //     final response = await dio.get(
  //       'viewproduct-env.eba-smbpywd9.ap-south-1.elasticbeanstalk.com/api/productInfoes/GetProductImage/110700255956/107',
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = response.data;
  //       return jsonResponse;
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception('Failed to load data');
  //   }
  // }
}
