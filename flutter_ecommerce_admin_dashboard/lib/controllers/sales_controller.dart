import 'package:get/get.dart';

class SalesController extends GetxController {
  Future<List<Map<String, dynamic>>> fetchData() async {
    return List.generate(
      5,
      (index) => {
        'salesId': 'SLS$index',
        'totalAmount': '\$${(index + 1) * 2000}',
        'orderCount': (index + 1) * 150,
        'date': '2025-07-1${index + 1}',
        'growth': '${(index + 1) * 5}%',
      },
    );
  }
}
