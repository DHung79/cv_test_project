import '../../base/rest/models/rest_api_response.dart';
import '../../base/models/common_model.dart';

class MediaModel extends BaseModel {
  final int _id;
  final String _type;
  final String _name;
  final String _image;

  MediaModel.fromJson(Map<String, dynamic> json)
      :
        // _user = BaseModel.map<UserModel>(
        //   json: json,
        //   key: 'posted_user',
        // ),
        _id = json['id'] ?? '',
        _type = json['type'] ?? '',
        _name = json['title']['romaji'] ?? '',
        _image = json['coverImage']['large'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': _id,
        'type': type,
        'name': _name,
      };
  int get id => _id;
  String get type => _type;
  String get name => _name;
  String get image => _image;
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
