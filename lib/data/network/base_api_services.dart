
abstract class BaseApiServices {
  Future<List<T>> getApi<T>(String url, T Function(Map<String, dynamic>) fromJson);
}