import 'package:tbs_app/api/api_response.dart';
import 'package:tbs_app/api/base_api.dart';
import 'package:tbs_app/api/mock_response.dart';
import 'package:dio/dio.dart';

class ApiService extends BaseApi {
  Future<ListPropertyResponse> findByTenant(String idTenant) async {
    if (this.isWeb()) {
      return await mockListProperty();
    }
    Dio dio = this.getClient();
    Response response = await dio.get('/api/v1/master/listtenant',
        queryParameters: {'idtenant': idTenant});
    if (response.statusCode == 200) {
      return ListPropertyResponse.fromJson(response.data);
    }
    throw Exception(response.statusMessage);
  }

  Future<ListNewsResponse> findNews() async {
    if (this.isWeb()) {
      return await mockListNews();
    }
    Dio dio = this.getClient();
    Response response = await dio.get('/api/v1/news/get');
    if (response.statusCode == 200) {
      return ListNewsResponse.fromJson(response.data);
    }
    throw Exception(response.statusMessage);
  }
}