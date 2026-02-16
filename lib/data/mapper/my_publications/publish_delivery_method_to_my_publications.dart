import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart'
    as mp;
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart'
    as publish;

extension PublishDeliveryMethodToMyPublications on publish.DeliveryMethod {
  mp.DeliveryMethod toMyPublicationsModel() {
    return mp.DeliveryMethod(
      id: id,
      deliveryType: switch (deliveryType) {
        publish.DeliveryType.delivery => mp.DeliveryType.delivery,
        publish.DeliveryType.pickupInPerson => mp.DeliveryType.pickupInPerson,
      },
      price: price,
      address: address,
      addressName: addressName,
      addressNumber: addressNumber,
      additionalNotes: additionalNotes,
      initPickupTime: initPickupTime,
      finishPickupTime: finishPickupTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
