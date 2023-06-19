import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class SelectorInput extends StatelessWidget {
  final List<InputItem> itemList;
  final InputItem? seleted;
  final bool isDisabled;
  final Axis direction;
  final void Function(InputItem?) onChanged;

  const SelectorInput({
    Key? key,
    required this.itemList,
    required this.seleted,
    this.isDisabled = false,
    this.direction = Axis.vertical,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildOptionGroup(context);
  }

  Widget _buildOptionGroup(BuildContext context) {
    if (itemList.isEmpty) {
      return const SizedBox.shrink();
    }
    if (direction == Axis.vertical) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          bool isSelected = itemList[index].value == (seleted?.value ?? "");
          return _buildOptionItem(
            context,
            isSelected: isSelected,
            title: itemList[index].displayLabel,
            onTap: () {
              if (isDisabled) return;
              onChanged(itemList[index]);
            },
          );
        },
      );
    } else {
      return Wrap(
        children: itemList.map((item) {
          bool isSelected = item.value == (seleted?.value ?? "");
          return _buildOptionItem(
            context,
            isSelected: isSelected,
            title: item.displayLabel,
            onTap: () {
              if (isDisabled) return;
              onChanged(item);
            },
          );
        }).toList(),
      );
    }
  }

  Widget _buildOptionItem(BuildContext context, {required bool isSelected, required String title, required void Function() onTap}) {
    TextStyle? textNormalStyle = const TextStyle(fontWeight: FontWeight.w600);
    TextStyle? textSelectedStyle = textNormalStyle.apply(color: AppColors.white);
    return InkWell(
      onTap: () {
        //Hide keyboard
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
        onTap.call();
      },
      borderRadius: BorderRadius.circular(AppProperties.circleRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppProperties.circleRadius),
          color: isSelected ? AppColors.secondary : AppColors.white,
        ),
        child: Text(
          title,
          style: isSelected ? textSelectedStyle : textNormalStyle,
        ),
      ),
    );
  }
}
