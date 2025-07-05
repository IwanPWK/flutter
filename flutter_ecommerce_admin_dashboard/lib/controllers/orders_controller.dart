import 'package:get/get.dart';

class OrdersController extends GetxController {
  Future<List<Map<String, dynamic>>> fetchData() async {
    return List.generate(
      5,
      (index) => {
        'orderId': 'ORD${(1000 + index)}',
        'customerName': 'Customer $index',
        'totalAmount': '\$${(index + 1) * 200}',
        'orderDate': '2025-07-1${index + 1}',
        'status': index % 2 == 0 ? 'Pending' : 'Delivered',
      },
    );
  }
}
