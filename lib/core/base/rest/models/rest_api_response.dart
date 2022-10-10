import '../../../media/media.dart';
import '../../logger/logger.dart';

class ApiError implements Exception {
  String _errorCode = '';
  String _errorMessage = '';

  ApiError.fromJson(Map<String, dynamic>? parsedJson) {
    if (parsedJson?['error_code'] != null) {
      _errorCode = parsedJson?['error_code']?.toString() ?? '';
    }
    _errorMessage = parsedJson?['error_message'] ?? '';
  }

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;

  @override
  String toString() {
    return _errorMessage;
  }
}

class ApiResponse<T> {
  ApiError? _error;
  T? _model;

  ApiResponse(T? m, ApiError? e) {
    _model = m;
    _error = e;
  }

  ApiError? get error => _error;
  T? get model => _model;
}

class BaseModel {
  static T fromJson<T extends BaseModel>(Map<String, dynamic> json) {
    // Models
    // if (T == Status) {
    //   return Status.fromJson(json) as T;
    // }
    // if (T == UserModel) {
    //   return UserModel.fromJson(json) as T;
    // }
    if (T == ListMediaModel) {
      return ListMediaModel.fromJson(json) as T;
    }
    if (T == MediaModel) {
      return MediaModel.fromJson(json) as T;
    }

    logError("Unknown BaseModel class: $T");
    throw Exception("Unknown BaseModel class: $T");
  }

  static List<T> mapList<T extends BaseModel>({
    required Map<String, dynamic> json,
    required String key,
    String defaultKey = '_id',
  }) {
    final _results = <T>[];
    if (json[key] != null && json[key] is List<dynamic>) {
      for (var val in json[key]) {
        if (val is String) {
          _results.add(BaseModel.fromJson<T>({defaultKey: val}));
        } else if (val is Map<String, dynamic>) {
          _results.add(BaseModel.fromJson<T>(val));
        } else {
          _results.add(BaseModel.fromJson<T>({}));
        }
      }
    }
    return _results;
  }

  static T listDynamic<T extends BaseModel>(List<dynamic> list) {
    // if (T == ListRoleModel) {
    //   return ListRoleModel.listDynamic(list) as T;
    // }

    logError("Unknown BaseModel class: $T");
    throw Exception("Unknown BaseModel class: $T");
  }

  static T map<T extends BaseModel>({
    required Map<String, dynamic> json,
    required String key,
    String defaultKey = '_id',
  }) {
    if (json.containsKey(key)) {
      final _val = json[key];
      if (_val is String) {
        return BaseModel.fromJson<T>({defaultKey: _val});
      } else if (_val is Map<String, dynamic>) {
        return BaseModel.fromJson<T>(_val);
      } else if (_val is List<dynamic> && _val.isNotEmpty) {
        return BaseModel.fromJson<T>(_val[0]);
      }
    }
    return BaseModel.fromJson({});
  }
}

class EditBaseModel {
  static T fromModel<T extends EditBaseModel>(BaseModel model) {
    // if (T == EditUserModel) {
    //   return EditUserModel.fromModel(model as UserModel) as T;
    // }
    logError("Unknown EditBaseModel class: $T");
    throw Exception("Unknown EditBaseModel class: $T");
  }

  static Map<String, dynamic> toCreateJson(EditBaseModel model) {
    // if (model is EditTaskModel) {
    //   return model.toCreateJson();
    // }
    return {};
  }

  static Map<String, dynamic> toChangePasswordJson(EditBaseModel model) {
    // if (model is EditUserModel) {
    //   return model.toChangePasswordJson();
    // }
    return {};
  }

  static Map<String, dynamic> toEditJson(EditBaseModel model) {
    // if (model is EditUserModel) {
    //   return model.toEditJson();
    // }
    return {};
  }
}
