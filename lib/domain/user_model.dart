
import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_model.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class User with _$User {
  User._();

  factory User({
    @JsonKey(name: 'profile_picture') String? profilePicture,
    @JsonKey(name: 'full_name') String? fullName,
    String? id,
    List<Message>? messages,

  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
