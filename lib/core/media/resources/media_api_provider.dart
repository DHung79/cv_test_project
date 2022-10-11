import 'dart:async';
import 'dart:convert' as convert;
import '../../base/constants/api_constants.dart';
import '../../base/helpers/api_helper.dart';
import '../../base/logger/logger.dart';
import '../../base/rest/models/rest_api_response.dart';
import '../../base/rest/rest_api_handler_data.dart';

class MediaApiProvider {
  Future<ApiResponse<T?>> fetchAllMedia<T extends BaseModel>({
    required String query,
    required Map<String, dynamic> variables,
  }) async {
    var path = ApiConstants.apiDomain;
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.getGraphql<T>(
      path: path,
      headers: ApiHelper.headers(token),
      query: query,
      variables: variables,
    );
    return response;
  }

  Future<ApiResponse<T?>> fetchMediaById<T extends BaseModel>({
    String? id,
  }) async {
    final path = '${ApiConstants.apiDomain}${ApiConstants.apiVersion}/$id';
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.getData<T>(
      path: path,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>> deleteMedia<T extends BaseModel>({
    required String id,
    required String reason,
  }) async {
    final path = '${ApiConstants.apiDomain}${ApiConstants.apiVersion}/$id';

    final body = convert.jsonEncode({
      "failure_reason": {"reason": reason}
    });
    logDebug('path: $path \n body: $body');
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.deleteData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>>
      createMedia<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) async {
    final path = ApiConstants.apiDomain + ApiConstants.apiVersion;
    final body = convert.jsonEncode(EditBaseModel.toCreateJson(editModel!));
    logDebug('path: $path\nbody: $body');
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.postData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>>
      editMedia<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) async {
    final path = '${ApiConstants.apiDomain}${ApiConstants.apiVersion}/$id';
    final body = convert.jsonEncode(EditBaseModel.toEditJson(editModel!));
    final token = await ApiHelper.getUserToken();
    logDebug('path: $path\nbody: $body');
    final response = await RestApiHandlerData.putData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future getMapSuggestion(String input) async {
    const String mapAPIKey = "AIzaSyB6gUxPMiSb_uEXaQjh7x3w1_1MGVxTGi0";
    const String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final path = '$baseURL?input=$input&key=$mapAPIKey';
    logDebug(path);
    final response = await RestApiHandlerData.getMapSuggestion(
      path: path,
    );
    return response;
  }
}
