import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snbs/api/data_uploader.dart';
import 'package:snbs/models/upload_item.dart';

class UploadingState extends ChangeNotifier {
  late DataUploader _dataUploader;
  static final ChangeNotifierProvider<UploadingState> state =
      ChangeNotifierProvider((_) => UploadingState());

  bool get itemsNeedToBeUploaded =>
      !_dataUploader.isUploading && _dataUploader.itemsAreQueued;
  bool get isUploading => _dataUploader.isUploading;

  UploadingState() {
    _dataUploader = DataUploader(
        uploadingDone: () => notifyListeners(),
        uploadingFailed: () => notifyListeners());
  }

  Future<void> queue(UploadItem item) => _dataUploader.queueItem(item);
  Future<void> upload() => _dataUploader.upload();
}
