import 'package:rxdart/rxdart.dart';
import '../../base/blocs/block_state.dart';
import '../../base/rest/api_helpers/api_exception.dart';
import '../../base/rest/models/rest_api_response.dart';
import '../media.dart';

class MediaBloc {
  final _repository = MediaRepository();
  final _allDataFetcher = BehaviorSubject<ApiResponse<ListMediaModel?>>();
  final _allDataState = BehaviorSubject<BlocState>();
  final _mediaDataFetcher = BehaviorSubject<ApiResponse<MediaModel?>>();

  Stream<ApiResponse<ListMediaModel?>> get allData => _allDataFetcher.stream;
  Stream<ApiResponse<MediaModel?>> get mediaData => _mediaDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  fetchAllData({String query = ''}) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data = await _repository.fetchAllData<ListMediaModel>(query: query);
      if (_allDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _allDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _allDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _allDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  fetchDataById(String id) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data = await _repository.fetchDataById<MediaModel>(id: id);
      if (_mediaDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _mediaDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _mediaDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _mediaDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  Future<MediaModel> deleteMedia({
    required String id,
    required String reason,
  }) async {
    try {
      // Await response from server.

      final data = await _repository.deleteMedia<MediaModel>(
        id: id,
        reason: reason,
      );
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  Future<MediaModel> createMedia({EditMediaModel? editModel}) async {
    try {
      // Await response from server.
      final data = await _repository.createMedia<MediaModel, EditMediaModel>(
        editModel: editModel,
      );
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  Future<MediaModel> editMedia({
    EditMediaModel? editModel,
    String? id,
  }) async {
    try {
      // Await response from server.

      final data = await _repository.editMedia<MediaModel, EditMediaModel>(
        editModel: editModel,
        id: id,
      );
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  Future getMapSuggestion(String input) async {
    try {
      // Await response from server.

      final data = await _repository.getMapSuggestion(input);
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  dispose() {
    _allDataFetcher.close();
    _mediaDataFetcher.close();
    _allDataState.close();
  }
}
