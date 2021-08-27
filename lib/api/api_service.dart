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

  Future<ListNewsResponse> findNews(String companyCode) async {
    if (this.isWeb()) {
      return await mockListNews();
    }
    Dio dio = this.getClient();
    var formData = FormData.fromMap({"CompanyCode": companyCode});
    Response response = await dio.post('/api/v1/news/get', data: formData);
    if (response.statusCode == 200) {
      return ListNewsResponse.fromJson(response.data);
    }
    throw Exception(response.statusMessage);
  }

  Future<NewsDetailResponse> getNews(String companyCode, String newsId) async {
    if (this.isWeb()) {
      return await mockNewsDetail();
    }
    Dio dio = this.getClient();
    var formData =
        FormData.fromMap({"CompanyCode": companyCode, "NewsId": newsId});
    Response response =
        await dio.post('/api/v1/news/get/detail', data: formData);
    if (response.statusCode == 200) {
      return NewsDetailResponse.fromJson(response.data);
    }
    throw Exception(response.statusMessage);
  }

  Future<ListTagihanResponse> findTagihan(
      String idTenant, String propertyCode) async {
    if (this.isWeb()) {
      return await mockListTagihan();
    }
    Dio dio = this.getClient();
    Response response = await dio.get('/api/v1/trans/listbill',
        queryParameters: {"idtenant": idTenant, "propertycode": propertyCode});
    if (response.statusCode == 200) {
      return ListTagihanResponse.fromJson(response.data);
    }
    throw Exception(response.statusMessage);
  }
}
