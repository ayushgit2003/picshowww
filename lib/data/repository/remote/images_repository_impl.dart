import 'package:picshow/Data/Network/network_api_services.dart';
import 'package:picshow/core/constants/app_url.dart';
import 'package:picshow/data/models/images/images.dart';
import '../../../domain/repository/images/images_repository.dart';

class ImagesRepositoryImpl implements ImagesRepository {
  final   _apiServices = NetworkApiService();

  @override
  Future<List<ImagesModel>> getImages(int page, int limit) async{
    await Future.delayed(Duration(seconds: 4));

    final response = await _apiServices.getApi<ImagesModel>(
      AppUrl.imagesList(page: page, limit: limit),
          (json) => ImagesModel.fromJson(json as Map<String, dynamic>),
    );
    return response;

  }
}
