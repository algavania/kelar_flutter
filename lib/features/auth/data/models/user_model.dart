import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String name,
    required String email,
    required String role,
    String? photoUrl,
    @JsonKey(includeToJson: false, includeFromJson: false)
    String? id,
    @JsonKey(includeToJson: false, includeFromJson: false)
    String? password,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
