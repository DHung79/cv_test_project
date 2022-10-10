import 'dart:async';

import '../../base/rest/models/rest_api_response.dart';
import 'media_api_provider.dart';

class MediaRepository {
  final _provider = MediaApiProvider();

  Future<ApiResponse<T?>> deleteMedia<T extends BaseModel>({
    required String id,
    required String reason,
  }) =>
      _provider.deleteMedia<T>(
        id: id,
        reason: reason,
      );

  Future<ApiResponse<T?>> fetchAllData<T extends BaseModel>({
    required String query,
  }) =>
      _provider.fetchAllMedia<T>(query: query);

  Future<ApiResponse<T?>> fetchDataById<T extends BaseModel>({
    String? id,
  }) =>
      _provider.fetchMediaById<T>(
        id: id,
      );

  Future<ApiResponse<T?>>
      editMedia<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.editMedia<T, K>(
            editModel: editModel,
            id: id,
          );

  Future<ApiResponse<T?>>
      createMedia<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) =>
          _provider.createMedia<T, K>(
            editModel: editModel,
          );

  Future getMapSuggestion(String input) => _provider.getMapSuggestion(input);
}
