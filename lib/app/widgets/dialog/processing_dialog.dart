import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
enum ProcessingType {
  threeBounce,
  circleIndicator,
  circlePercent,
}

class ProcessingDialog {
  ProcessingDialog({
    this.type = ProcessingType.threeBounce,
    this.contentSize = const Size(160, 140),
    this.message = "",
  });
  bool isShowing = false;
  BuildContext? dialogContext;
  final ProcessingType type;
  final Size contentSize;
  final String message;
  final _progressValue = (0.0).obs;

  factory ProcessingDialog.show({
    ProcessingType type = ProcessingType.threeBounce,
    Size contentSize = const Size(160, 140),
    String message = "",
  }) {
    ProcessingDialog dialog = ProcessingDialog(
      type: type,
      contentSize: contentSize,
      message: message,
    );
    dialog.show();
    return dialog;
  }

  void updatePercent(double value) {
    if (isShowing) {
      _progressValue.value = value / 100.0;
    }
  }

  void hide() async {
    if (!isShowing) return;
    if (dialogContext != null) {
      Navigator.of(dialogContext!).pop();
    } else {
      Get.back<void>();
    }
  }

  void show() {
    if (!isShowing && Get.context != null) {
      isShowing = true;
      showDialog<void>(
        context: Get.context!,
        builder: (context) {
          dialogContext = context;
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppProperties.circleRadius),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Center(
                child: _buildLoadingContent(context),
              ),
            ),
          );
        },
        barrierDismissible: false,
      ).then((value) {
        isShowing = false;
      });
    }
  }

  Widget _buildLoadingContent(BuildContext context) {
    switch (type) {
      case ProcessingType.threeBounce:
        return ThreeBounceLoading();
      case ProcessingType.circleIndicator:
        return const CircularProgressIndicator();
      case ProcessingType.circlePercent:
        return Container(
          padding: const EdgeInsets.all(AppProperties.contentMargin),
          width: contentSize.width,
          height: contentSize.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppProperties.dialogCircleRadius,
            ),
            color: Theme.of(context).dialogBackgroundColor,
          ),
          child: DisableAccessibility(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Obx(
                    () {
                      double progress = _progressValue.value;
                      String percent =
                          (progress * 100.0).toStringAsFixed(0) + "%";
                      return CustomPaint(
                        size: const Size(60, 60),
                        painter: CircularPainter(
                          progressValue: progress,
                          gradientColor: LinearGradient(
                            colors: [
                              AppColors.main,
                              AppColors.main.shade400,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            percent,
                            style:
                                Theme.of(context).textTheme.headline5?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: AppColors.main.shade400,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        );
    }
  }
}
