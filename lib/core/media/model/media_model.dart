import 'package:cv_test_project/core/base/logger/logger.dart';

import '../../base/rest/models/rest_api_response.dart';
import '../../base/models/common_model.dart';

class MediaModel extends BaseModel {
  final int _id;
  final String _type;
  final int _startTime;
  final int _endTime;
  final int _date;
  final String _name;
  final int _status;
  final int _typeHome;
  final bool _isRating;
  final int _createdTime;
  final int _updatedTime;
  final int _totalPrice;
  final List<CheckListModel> _checkList = [];
  final String _addressTitle;
  final List<String> _listPicturesBefore = [];
  final List<String> _listPicturesAfter = [];
  final bool _userDeleted;
  final bool _mediaerDeleted;

  MediaModel.fromJson(Map<String, dynamic> json)
      :
        // _user = BaseModel.map<UserModel>(
        //   json: json,
        //   key: 'posted_user',
        // ),
        _id = json['id'] ?? '',
        _type = json['type'] ?? '',
        _startTime = json['start_time'] ?? 0,
        _endTime = json['end_time'] ?? 0,
        _date = json['date'] ?? 0,
        _name = json['title']['english'] ?? '',
        _status = json['status'] ?? 0,
        _typeHome = json['type_home'] ?? 0,
        _isRating = json['is_rating'] ?? false,
        _createdTime = json['created_time'] ?? 0,
        _updatedTime = json['updated_time'] ?? 0,
        _totalPrice = json['total_price'] ?? 0,
        _userDeleted = json['user_deleted'] ?? false,
        _mediaerDeleted = json['mediaer_deleted'] ?? false,
        _addressTitle = json['address_title'] ?? '' {
    _checkList.addAll(BaseModel.mapList<CheckListModel>(
      json: json,
      key: 'check_list',
    ));
    if (json['list_pictures_before'] != null) {
      final jsons = json['list_pictures_before'];
      if (jsons is List<dynamic>) {
        for (var item in jsons) {
          if (item is String) {
            _listPicturesBefore.add(item);
          }
        }
      }
    }
    if (json['list_pictures_after'] != null) {
      final jsons = json['list_pictures_after'];
      if (jsons is List<dynamic>) {
        for (var item in jsons) {
          if (item is String) {
            _listPicturesAfter.add(item);
          }
        }
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'type': type,
        'name': _name,
      };
  int get id => _id;
  String get type => _type;
  String get name => _name;
}

class EditMediaModel extends EditBaseModel {
  AddressModel address = AddressModel.fromJson({});
  List<CheckListModel> checkList = [];
  String estimateTime = '';
  int startTime = 0;
  int endTime = 0;
  int date = 0;
  String note = '';
  int status = 0;
  int typeHome = 0;
  int totalPrice = 0;
  String addressTitle = '';

  EditMediaModel.fromModel(MediaModel? model) {
    estimateTime = model?.type ?? '';
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      'address': address.toJson(),
    };
    return params;
  }

  Map<String, dynamic> toEditMediaJson() {
    Map<String, dynamic> params = {
      'address': address.toJson(),
    };
    return params;
  }
}

class AddressModel extends BaseModel {
  String name;
  String subName;
  String lat;
  String long;
  String location;

  AddressModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        subName = json['sub_name'] ?? '',
        lat = json['lat'] ?? '',
        long = json['long'] ?? '',
        location = json['location'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'sub_name': subName,
        'lat': lat,
        'long': long,
        'location': location,
      };
}

class ListMediaModel extends BaseModel {
  List<MediaModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListMediaModel.fromJson(Map<String, dynamic> parsedJson) {
    List<MediaModel> tmp = [];
    logDebug(parsedJson['Page']['media']);
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
