import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

@injectable
class DeliveryMethodDataSource {
  final DioClient _dioClient;

  DeliveryMethodDataSource(this._dioClient);

  Future<DeliveryMethod> createDeliveryMethod(DeliveryMethod method) async {
    final data = method.toJson();
    // Backend expects date only (YYYY-MM-DD), remove time component to avoid 422
    if (method.initPickupTime != null) {
      data['initPickupTime'] =
          method.initPickupTime!.toIso8601String().split('T').first;
    }
    if (method.finishPickupTime != null) {
      data['finishPickupTime'] =
          method.finishPickupTime!.toIso8601String().split('T').first;
    }

    final response = await _dioClient.post<Map<String, dynamic>>(
      '/api/delivery-methods',
      data: data,
    );
    return DeliveryMethod.fromJson(response.data!);
  }

  Future<List<DeliveryMethod>> getDeliveryMethods() async {
    final response =
        await _dioClient.get<List<dynamic>>('/api/delivery-methods');
    return response.data!
        .map((e) => DeliveryMethod.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
