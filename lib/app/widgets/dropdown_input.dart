import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class DropdownInput extends StatefulWidget {
  final List<InputItem> itemList;
  final InputItem? seleted;
  final bool isDisabled;
  final String label;
  final String hint;
  final double verticalMargin;
  final void Function(InputItem?) onChanged;

  const DropdownInput({
    Key? key,
    required this.itemList,
    required this.seleted,
    this.isDisabled = false,
    this.label = "",
    this.hint = "",
    this.verticalMargin = 0,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  final List<ScrollController> _scrollControllerList = [];
  @override
  void dispose() {
    if (_scrollControllerList.isNotEmpty) {
      for (var controller in _scrollControllerList) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<InputItem>> dropItems =
        <DropdownMenuItem<InputItem>>[];
    for (var item in widget.itemList) {
      bool isSelected = (item.value == (widget.seleted?.value ?? ""));
      TextStyle? textNormalStyle = TextStyle(
        color: AppColors.grey.shade400,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
      TextStyle? textDisable = TextStyle(
        color: AppColors.grey.shade200,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
      TextStyle? textSelectedStyle =
          textNormalStyle; //?.apply(color: Theme.of(context).scaffoldBackgroundColor);
      dropItems.add(
        DropdownMenuItem<InputItem>(
          key: ValueKey(item.value),
          value: item,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppProperties.circleRadius),
                  color: isSelected ? AppColors.grey.shade100 : AppColors.white,
                ),
                child: Text(
                  item.displayLabel,
                  style: (item.isDisable ?? false)
                      ? textDisable
                      : isSelected
                          ? textSelectedStyle
                          : textNormalStyle,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return _buildDropDownFormItem(context, dropItems);
  }

  Widget _buildDropDownFormItem(
      BuildContext context, List<DropdownMenuItem<InputItem>> dropItems) {
    // ignore: unused_local_variable
    for (var item in dropItems) {
      _scrollControllerList.add(ScrollController());
    }
    // if (ObjectUtil.isEmptyList(dropItems)) {
    //   return const SizedBox.shrink();
    // }
    DropdownMenuItem<InputItem>? valueSelected = dropItems.firstWhereOrNull(
        (DropdownMenuItem<InputItem> it) =>
            it.value?.value == (widget.seleted?.value ?? ""));
    return DropdownButtonHideUnderline(
      child: IgnorePointer(
        ignoring: widget.isDisabled,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: widget.verticalMargin),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: AppProperties.inputHight,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                style: BorderStyle.solid,
                color: widget.isDisabled
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
            ),
            color: widget.isDisabled ? AppColors.grey : AppColors.white,
          ),
          child: ButtonTheme(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: DropdownButton(
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
              elevation: AppElevation.popup,
              dropdownColor:
                  widget.isDisabled ? AppColors.grey : AppColors.white,
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.hint,
                  style: const TextStyle(
                    color: AppColors.main,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              isExpanded: true,
              value: valueSelected?.value,
              iconEnabledColor: widget.isDisabled
                  ? Theme.of(context).disabledColor
                  : AppColors.main,
              items: dropItems,
              onChanged: (InputItem? val) => widget.onChanged(val),
              onTap: () {
                //Hide keyboard
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              selectedItemBuilder: (BuildContext context) {
                return widget.itemList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      widget.label.isNotEmpty
                          ? Text(
                              widget.label,
                              style: TextStyle(
                                color: widget.isDisabled
                                    ? AppColors.grey.shade500
                                    : AppColors.grey.shade400,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: ScrollWrapper(
                          thumbVisibility: _scrollControllerList.isNotEmpty,
                          thickness: 2.0,
                          color: AppColors.grey.shade300,
                          controller: _scrollControllerList.elementAt(index),
                          child: SingleChildScrollView(
                            controller: _scrollControllerList.elementAt(index),
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              item.displayLabel,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.main.shade200,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.label.isNotEmpty
                          ? const SizedBox(height: 11)
                          : const SizedBox.shrink(),
                    ],
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
