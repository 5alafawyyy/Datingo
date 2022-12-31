import 'dart:async';

import 'package:datingo/repositories/database/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubscription;
  ImagesBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(ImagesLoading()) {
    on<LoadImages>(_onLoadImages);
    on<UpdateImages>(_onUpdateImages);
  }

  FutureOr<void> _onLoadImages(
    LoadImages event,
    Emitter<ImagesState> emit,
  ) {
    _databaseSubscription?.cancel();
    _databaseRepository.getUser().listen(
          (user) => add(UpdateImages(user.imageUrls)),
        );
  }

  FutureOr<void> _onUpdateImages(
    UpdateImages event,
    Emitter<ImagesState> emit,
  ) {
    emit(ImagesLoaded(imageUrls: event.imageUrls));
  }

  @override
  Future<void> close() {
    _databaseSubscription?.cancel();
    return super.close();
  }
}
