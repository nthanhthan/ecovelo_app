import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecoveloapp/app/core.dart';


class TextFieldSearch extends StatefulWidget {
  final bool enabled;
  final double? width;
  final double? borderRadius;
  final bool autofocus;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final String? helperText;
  final String? initialValue;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController inputController;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? onFieldSubmitted;
  final BoxConstraints? suffixIconConstraints;
  final String? tagId;
  final List<TextInputFormatter>? inputFormatters;
  final Color disableBorderColor;
  final bool autoTrimValidator;
  final Color? inputBorderColor;
  final String? prefixText;
  final TextInputAction? textInputAction;
  final bool isApplyDebounceTextChanged;
  final void Function()? onUnFocus;
  final void Function()? onCleanSearch;

  const TextFieldSearch({
    Key? key,
    required this.inputController,
    this.maxLength,
    this.enabled = true,
    this.onChanged,
    this.keyboardType,
    this.onFieldSubmitted,
    this.hintText = 'Search',
    this.margin,
    this.autofillHints,
    this.helperText,
    this.initialValue,
    this.onTap,
    this.autofocus = false,
    this.maxLines = 1,
    this.suffixIconConstraints,
    this.width,
    this.borderRadius,
    this.tagId,
    this.inputFormatters,
    this.disableBorderColor = Colors.grey,
    this.autoTrimValidator = true,
    this.inputBorderColor,
    this.prefixText,
    this.textInputAction = TextInputAction.search,
    this.isApplyDebounceTextChanged = false,
    this.onUnFocus,
    this.onCleanSearch,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  final Debouncer debouncer = Debouncer(milliseconds: 400);
  final FocusNode _focusNode = FocusNode();
  bool _isFocus = false;
  bool _isSearched = false;
  bool _isFilled = true;

  String? trimText = "";

  Widget? getSuffixIcon() {
    if (_isSearched) {
      return InkWell(
        onTap: () {
          widget.inputController.clear();
          setState(() {
            _isSearched = false;
            _isFilled = !_isFocus;
          });

          _focusNode.requestFocus();
          widget.onCleanSearch?.call();
        },
        child: const Icon(
          Icons.close,
          color: AppColors.black,
        ),
      );
    }

    return null;
  }

  Widget? getPrefixIcon() {
    if (!_isSearched) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
          Icons.search,
          color: getHintColor(),
        ),
      );
    }

    return null;
  }

  Color? getFillColor() {
    if (!_isFocus && widget.inputController.text.isEmpty) {
      return AppColors.grey.shade100;
    }

    return AppColors.main.shade600;
  }

  Color getTextColor() {
    if (!widget.enabled) {
      return AppColors.grey.shade300;
    }

    if (_isSearched) {
      return AppColors.main;
    }

    return AppColors.grey.shade900;
  }

  Color getHintColor() {
    if (!widget.enabled) {
      return AppColors.grey.shade300;
    }

    if (_isFilled) {
      return AppColors.main.shade400;
    }

    return AppColors.main;
  }

  @override
  void initState() {
    super.initState();
    _isFilled = widget.enabled;

    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
        _isFilled = !_isFocus && widget.inputController.text.isEmpty;
      });
      if (!_focusNode.hasFocus) {
        LogUtil.d("Search unfocus!");
        widget.onUnFocus?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisableAccessibility(
      child: TextFormField(
        onTap: widget.onTap,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        onChanged: (String? val) {
          if (widget.autoTrimValidator) {
            val = val?.trim();
          }

          if (_isSearched == true) {
            setState(() {
              _isSearched = false;
            });
          }

          if (trimText == val) return;

          if (widget.isApplyDebounceTextChanged) {
            debouncer.run(() => widget.onChanged?.call(val ?? ''));
          } else {
            widget.onChanged?.call(val ?? '');
          }

          trimText = val?.trim();
        },
        autofocus: widget.autofocus,
        maxLength: widget.maxLength,
        focusNode: _focusNode,
        style: TextStyle(
          color: getTextColor(),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        controller: widget.inputController,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        autofillHints: widget.autofillHints,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: (val) {
          widget.onFieldSubmitted?.call(val);
          setState(() {
            _isSearched = val.isNotEmpty;
          });
        },
        cursorColor: Theme.of(context).primaryColor,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          isCollapsed: true,
          alignLabelWithHint: true,
          prefixText: widget.prefixText,
          fillColor: getFillColor(),
          filled: _isFilled,
          hintText: widget.hintText,
          helperText: widget.helperText,
          suffixIcon: getSuffixIcon(),
          prefixIcon: getPrefixIcon(),
          hintStyle: TextStyle(
            color: getHintColor(),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          suffixIconConstraints: widget.suffixIconConstraints,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.main,
              width: 1,
              style: _isFilled ? BorderStyle.none : BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.main,
              width: 1,
              style: _isFilled ? BorderStyle.none : BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffB9B9B9),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.main,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
        ),
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: (widget.inputFormatters ?? [])
          ..insertAll(0, [
            FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
            NoLeadingSpaceFormatter(),
          ]),
      ),
    );
  }
}
