import 'package:mobile_table_hopping/data/dto/my_publications/publication_update_body.dart';
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';

/// Extension to convert [UpdatePublicationParams] to [PublicationUpdateBody].
///
/// This mapper handles the conversion from domain params to data layer DTO,
/// ensuring proper mapping of fields and handling any transformation logic.
extension UpdatePublicationParamsMapper on UpdatePublicationParams {
  /// Converts this params object to a [PublicationUpdateBody].
  ///
  /// Maps all fields from the domain params to the corresponding DTO fields.
  PublicationUpdateBody toBody() {
    return PublicationUpdateBody(
      description: description,
      condition: condition,
      price: price,
      images: images,
      deliveryMethodIds: deliveryMethodIds,
    );
  }
}
