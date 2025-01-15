import 'package:freezed_annotation/freezed_annotation.dart';
part 'images.freezed.dart';
part 'images.g.dart';

@freezed
class ImagesModel with _$ImagesModel {
  const factory ImagesModel({
     required String id,
     required String author,
     required int width,
    required int height,
     required String url,

    @JsonKey(name: 'download_url') required String downloadUrl,
  }) = _ImagesModel;

  factory ImagesModel.fromJson(Map<String, dynamic> json) =>
      _$ImagesModelFromJson(json);
}
