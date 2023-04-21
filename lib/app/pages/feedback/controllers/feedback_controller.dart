
import 'package:ecoveloapp/app/core.dart';

class FeedbackController extends GetxController {
  late final int _bikeFallCount;
  late int _star; 
  final _isShowFeedback = false.obs;

  get bikeFallCount => _bikeFallCount;
  get star => _star;
  set star(value) => _star = value;
  get isShowFeedback => _isShowFeedback.value;
  set isShowFeedback(value) => _isShowFeedback.value = value;

  @override
  void onInit() {
    _bikeFallCount = 2;
    super.onInit();
  }
}