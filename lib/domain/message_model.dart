
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

part 'message_model.g.dart';

@freezed
class Message with _$Message {
  Message._();

  factory Message({
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'sender_id') String? senderId,
    @JsonKey(name: 'receiver_id') String? receiverId,
    String? id,
    String? content,
    String? image,

  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
