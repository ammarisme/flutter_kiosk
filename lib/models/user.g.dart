// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  final billing_info = BillingInfo(
      company: json["billing"]["company"],
      state: json["billing"]["state"],
      email: json["billing"]["email"],
      first_name: json["billing"]["first_name"],
      phone:json["billing"]["phone"],
      last_name: json["billing"]["last_name"],
      address_1: json["billing"]["address_1"],
      address_2: json["billing"]["address_2"],
      city: json["billing"]["city"],
      postcode: json["billing"]["postcode"],
      country: json["billing"]["country"]);
  
  final shipping_info = ShippingInfo();

  User user =  User(
      id: json["id"],
      email: json["email"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      role: json["role"],
      username: json["username"],
      avatar_url: json["avatar_url"],
      billing_info: billing_info,
      shipping_info: shipping_info,
      phone_number: "0777123030"
      );
    user.billing_info = billing_info;
    return user;

}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
    };
