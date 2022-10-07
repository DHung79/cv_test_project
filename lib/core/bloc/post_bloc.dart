import 'package:chopper/chopper.dart';
import 'package:cv_test_project/core/logger/logger.dart';
import 'package:cv_test_project/core/models/post_model.dart';
import 'package:rxdart/rxdart.dart';
import '../repositories/post_repo_implement.dart';

enum BlocState {
  fetching,
  completed,
}

class PostBloc {
  final PostRepoImplement _repository = PostRepoImplement();
  final _allDataFetcher = BehaviorSubject<Response<List<PostModel>>>();
  final _allDataState = BehaviorSubject<BlocState>();
  final _postDataFetcher = BehaviorSubject<Response<dynamic>>();

  Stream<Response<List<PostModel>>> get allData => _allDataFetcher.stream;
  Stream<Response<dynamic>> get postData => _postDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  getPosts({Map<String, dynamic>? params}) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      var data = await _repository.getPosts();
      if (_allDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _allDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _allDataFetcher.sink.add(data);
      }
    } on Error catch (e) {
      _allDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  specialPost(int id) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      var data = await _repository.specialPost(id);
      logDebug(data.runtimeType);
      if (_postDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _postDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _postDataFetcher.sink.add(data);
      }
    } on Error catch (e) {
      _postDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  dispose() {
    _allDataFetcher.close();
    _postDataFetcher.close();
    _allDataState.close();
  }
}
