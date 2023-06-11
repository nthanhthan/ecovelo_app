import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class FeedbackController extends GetxController {
  late final int _bikeFallCount;
  late double _star;
  final _isShowFeedback = false.obs;

  get bikeFallCount => _bikeFallCount;
  get star => _star;
  set star(value) => _star = value;
  get isShowFeedback => _isShowFeedback.value;
  set isShowFeedback(value) => _isShowFeedback.value = value;

  TextEditingController reasonController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  StopResponse? stopResponse;

  late FeeadbackService _feeadbackService;
  @override
  void onInit() {
    _feeadbackService = Get.find<FeeadbackService>();
    if (Get.arguments != null && Get.arguments is StopResponse) {
      stopResponse = Get.arguments as StopResponse;
      _bikeFallCount = stopResponse?.numFall ?? 0;
    }
    _star = 5;
    super.onInit();
  }

  Future<bool> feedBackTrip() async {
    try {
      ProcessingDialog processingDialog = ProcessingDialog.show();
      if (stopResponse != null && stopResponse!.idRent != null) {
        FeedbackRequest feedbackRequest = FeedbackRequest(
          comment: feedbackController.text,
          reasonFall: reasonController.text,
          numStar:  star.toInt(),
          idRent: stopResponse!.idRent,
        );
        final result = await _feeadbackService.feedback(feedbackRequest);
        if (result.isSuccess() && result.data != null) {
          processingDialog.hide();
          if (result.data == true) {
            return true;
          }
          return false;
        }
        processingDialog.hide();
        return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
