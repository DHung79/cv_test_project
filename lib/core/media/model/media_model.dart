import '../../base/rest/models/rest_api_response.dart';
import '../../base/models/common_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_model.freezed.dart';
part 'media_model.g.dart';

@freezed
abstract class MediaModel extends BaseModel with _$MediaModel {
  const factory MediaModel({
    int? id,
    String? name,
    String? type,
    String? image,
  }) = _MediaModel;
  factory MediaModel.fromJson(Map<String, Object?> json) =>
      _$MediaModelFromJson(json);
}

class EditMediaModel extends EditBaseModel {
  String estimateTime = '';
  int startTime = 0;
  int endTime = 0;
  int date = 0;

  EditMediaModel.fromModel(MediaModel? model) {
    estimateTime = model?.type ?? '';
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      // 'address': address.toJson(),
    };
    return params;
  }

  Map<String, dynamic> toEditMediaJson() {
    Map<String, dynamic> params = {
      // 'address': address.toJson(),
    };
    return params;
  }
}

class ListMediaModel extends BaseModel {
  List<MediaModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListMediaModel.fromJson(Map<String, dynamic> parsedJson) {
    List<MediaModel> tmp = [];
    for (int i = 0; i < parsedJson['Page']['media'].length; i++) {
      var result =
          BaseModel.fromJson<MediaModel>(parsedJson['Page']['media'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromGraphqlJson(parsedJson['Page']['pageInfo']);
  }

  List<MediaModel> get records => _data;
  Paging get meta => _metaData;
}

class CheckListModel extends BaseModel {
  final String _name;
  final bool _status;
  // final String __id;

  CheckListModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? '',
        _status = json['status'] ?? false;
  // __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': _name,
        'status': _status,
        // '_id': __id,
      };

  String get name => _name;
  bool get status => _status;
  // String get id => __id;
}
