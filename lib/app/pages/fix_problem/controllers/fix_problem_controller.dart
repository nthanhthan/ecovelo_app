import 'package:ecoveloapp/app/core.dart';

class FixProblemController extends GetxController {
  final RxList<InputItem> _priority = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get priorities => _priority.value;
  set priorities(List<InputItem> value) => _priority.value = value;

  final _prioritySelected = InputItem.empty().obs;
  InputItem get prioritySelected => _prioritySelected.value;
  set prioritySelected(InputItem value) {
    _prioritySelected.value = value;
  }

  List<InputItem> listType = [
    InputItem(
      value: "Not processed yet",
      displayLabel: "Not processed yet",
    ),
    InputItem(
      value: "Processing",
      displayLabel: "Processing",
    ),
    InputItem(
      value: "Processed",
      displayLabel: "Processed",
    ),
  ];
  @override
  void onInit() {
    priorities = listType;
    prioritySelected = priorities[0];
    super.onInit();
  }
}
