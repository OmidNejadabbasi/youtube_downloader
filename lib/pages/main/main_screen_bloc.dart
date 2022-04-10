import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:youtube_downloader/data/db/database.dart';
import 'package:youtube_downloader/domain/repository/download_item_repository.dart';

import 'main_screen_states.dart';

class MainScreenBloc {

  late DownloadItemRepository _repository;

  MainScreenBloc(DownloadItemRepository repository){

    _repository = repository;
    _repository.getAllItemsStream().listen((event) {
      _mainScreenStateSubject.add(MainScreenState(observableItemList: event.map((e) => BehaviorSubject.seeded(e)).toList()));
    });
  }

  final _mainScreenStateSubject = BehaviorSubject<MainScreenState>();

  Stream<MainScreenState> get mainScreenState => _mainScreenStateSubject.stream;


  void setMainScreenState(MainScreenState state) {
    _mainScreenStateSubject.sink.add(state);
  }

  void dispose() {
    _mainScreenStateSubject.close();
  }

}