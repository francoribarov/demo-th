import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address.freezed.dart';
part 'user_address.g.dart';

@freezed
abstract class UserAddress with _$UserAddress {
  const factory UserAddress({
    required String address,
    required String addressName,
    required String number,
    String? additionalNotes,
  }) = _UserAddress;

  factory UserAddress.fromJson(Map<String, dynamic> json) => _$UserAddressFromJson(json);
}
