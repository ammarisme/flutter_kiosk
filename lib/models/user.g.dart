// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  final billing_info = BillingInfo();
  final shipping_info = ShippingInfo();

  return User(
      id: json["id"],
      email: json["email"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      role: json["role"],
      username: json["username"],
      avatar_url: json["avatar_url"],
      billing_info: billing_info,
      shipping_info: shipping_info,
      phone_number: "0777123030");
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
    };
