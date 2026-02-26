import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';

/// Maps data-layer exceptions to domain-layer exceptions.
extension DataExceptionMapper on DataException {
  DomainException toDomainException() {
    return DomainException(
      message: message,
      statusCode: statusCode,
    );
  }
}
