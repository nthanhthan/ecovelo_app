import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecoveloapp/app/core.dart';

enum InputBorderType {
  underline,
  borderSide,
}

class TextFieldInput extends StatefulWidget {
  final bool enabled;
  final bool readOnly;
  final double? width;
  final double? borderRadius;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final String? counterText;
  final String? initialValue;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Widget? suffixIcon, prefixIcon;
  final TextInputAction? textInputAction;
  final TextEditingController? inputController;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final Function(String?)? onFieldSubmitted;
  final BoxConstraints? suffixIconConstraints;
  final String? tagId;
  final List<TextInputFormatter>? inputFormatters;
  final Color disableBorderColor;
  final bool autoTrimValidator;
  final Color? inputBorderColor;
  final String? prefixText;
  final bool isFilled;
  final Color? fillColor;
  final Function()? onEditingComplete;
  final bool isSearch;
  final bool isExpand;
  final TextAlignVertical textAlignVertical;
  final InputBorder? inputBorder;
  final TextStyle? hintTextStyle;
  final bool isShowSuffixMaxLength;
  final ScrollController? scrollController;
  final bool isAllowEmoji;
  final bool isShowClearIcon;
  final bool isEnableErrorMessage;
  final InputBorderType inputBorderType;
  final EdgeInsets? scrollPadding;
  final bool enableSuggestions;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final Function? onClearText;
  final bool isApplyNoLeadingSpace;
  final bool isApplyDebounceTextChanged;
  final bool isApplyFirstCharacterCapitalization;

  const TextFieldInput({
    Key? key,
    this.inputController,
    this.labelText,
    this.maxLength,
    this.focusNode,
    this.enabled = true,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.errorText,
    this.margin,
    this.obscureText = false,
    this.suffixIcon,
    this.autofillHints,
    this.helperText,
    this.prefixIcon,
    this.initialValue,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.suffixIconConstraints,
    this.width,
    this.counterText,
    this.borderRadius,
    this.autovalidateMode,
    this.tagId,
    this.inputFormatters,
    this.disableBorderColor = Colors.grey,
    this.autoTrimValidator = true,
    this.inputBorderColor,
    this.prefixText,
    this.isFilled = true,
    this.fillColor,
    this.onEditingComplete,
    this.isSearch = false,
    this.isExpand = false,
    this.textAlignVertical = TextAlignVertical.bottom,
    this.hintTextStyle,
    this.inputBorder,
    this.isShowSuffixMaxLength = false,
    this.scrollController,
    this.isAllowEmoji = false,
    this.isShowClearIcon = true,
    this.isEnableErrorMessage = true,
    this.inputBorderType = InputBorderType.borderSide,
    this.scrollPadding,
    this.enableSuggestions = true,
    this.contentPadding,
    this.textStyle,
    this.onClearText,
    this.isApplyNoLeadingSpace = true,
    this.isApplyDebounceTextChanged = false,
    this.isApplyFirstCharacterCapitalization = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  final Debouncer debouncer = Debouncer(milliseconds: 400);
  bool isObscure = true;
  bool _isFocus = false;

  InputBorder? _getDefaultInputBorder() {
    InputBorder? inputBorder;
    switch (widget.inputBorderType) {
      case InputBorderType.underline:
        inputBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.main.shade200),
        );
        break;
      case InputBorderType.borderSide:
        break;
    }
    return inputBorder;
  }

  Widget? getSuffixIcon() {
    if (widget.isShowSuffixMaxLength) {
      return null;
    }

    if (widget.obscureText) {
      if (widget.inputController?.text == '') return null;

      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: isObscure
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: AppColors.main,
                      )
                    : const Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.main,
                      )),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                widget.inputController?.clear();
                widget.onChanged?.call("");
                setState(() {});
              },
              child: const Icon(
                Icons.close,
                color: AppColors.black,
              ),
            )
          ],
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return widget.suffixIcon!;
    }

    if (widget.inputController?.text != '' && widget.isShowClearIcon) {
      return InkWell(
        onTap: () {
          widget.inputController?.clear();
          widget.onChanged?.call("");
          widget.onClearText?.call();
          setState(() {});
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
    if (_isFocus && widget.isSearch) {
      return Container(
        padding: const EdgeInsets.all(12),
        child: const Icon(Icons.search, color: AppColors.main),
      );
    }

    return widget.prefixIcon;
  }

  String? getSuffixText() {
    if (widget.isShowSuffixMaxLength && widget.inputController != null) {
      int textLength = 0;
      textLength = widget.inputController?.text.length ?? 0;
      if (widget.isAllowEmoji) {
        RegExp exp = RegExp(emojisUnicodes);
        Iterable<Match> matches =
            exp.allMatches(widget.inputController?.text ?? "");
        int emojiLength = 0;
        for (var m in matches) {
          emojiLength += (m.group(0)?.length ?? 0);
        }
        textLength = textLength - emojiLength + matches.length;
      }
      return '$textLength/${widget.maxLength ?? 50}';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(() {
        if (mounted) {
          setState(() {
            _isFocus = widget.focusNode?.hasFocus ?? false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DisableAccessibility(
      child: TextFormField(
        autovalidateMode: widget.autovalidateMode,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        textAlign: TextAlign.center,
        scrollController: widget.scrollController,
        onChanged: (String? val) {
          if (widget.autoTrimValidator) {
            val = val?.trim();
          }

          if (widget.isApplyDebounceTextChanged) {
            debouncer.run(() => widget.onChanged?.call(val ?? ''));
          } else {
            widget.onChanged?.call(val ?? '');
          }

          setState(() {});
        },
        validator: (String? val) {
          if (widget.autoTrimValidator) {
            val = val?.trim();
          }
          if (widget.validator != null) {
            String? errorMessage = widget.validator?.call(val);
            if (errorMessage != null) {
              return errorMessage;
            }
          }

          return null;
        },
        autofocus: widget.autofocus,
        maxLength: widget.maxLength,
        expands: widget.isExpand,
        focusNode: widget.focusNode,
        style: widget.textStyle ??
            TextStyle(
              color: widget.enabled ? AppColors.white : AppColors.grey[300],
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        controller: widget.inputController,
        obscureText: isObscure,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        autofillHints: widget.autofillHints,
        textInputAction: widget.textInputAction,
        enableSuggestions: widget.enableSuggestions,
        onFieldSubmitted: widget.onFieldSubmitted,
        cursorColor: AppColors.main.shade300,
        textAlignVertical: widget.textAlignVertical,
        scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: widget.contentPadding,
          alignLabelWithHint: true,
          prefixText: widget.prefixText,
          labelStyle: TextStyle(
            height: 5,
            color: Theme.of(context).primaryColor,
          ),
          fillColor: widget.isFilled ? widget.fillColor : null,
          filled: widget.isFilled,
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          errorText: widget.errorText,
          errorStyle: widget.isEnableErrorMessage
              ? null
              : const TextStyle(
                  height: 0.001,
                  color: Colors.transparent,
                ),
          errorMaxLines: 10,
          helperText: widget.helperText,
          suffixIcon: getSuffixIcon(),
          suffixText: getSuffixText(),
          prefixIcon: getPrefixIcon(),
          suffixIconConstraints: widget.suffixIconConstraints,
          focusedBorder: widget.inputBorder ?? _getDefaultInputBorder(),
          border: widget.inputBorder ?? _getDefaultInputBorder(),
          enabledBorder: widget.inputBorder ?? _getDefaultInputBorder(),
          semanticCounterText: null,
          counterText: widget.counterText,
        ),
        textCapitalization: widget.isApplyFirstCharacterCapitalization
            ? TextCapitalization.sentences
            : TextCapitalization.characters,
        inputFormatters: (widget.inputFormatters ?? [])
          ..insertAll(0, [
            if (!widget.isAllowEmoji)
              FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
            if (widget.isApplyNoLeadingSpace) NoLeadingSpaceFormatter(),
            if (widget.maxLength != null)
              LengthLimitingTextInputFormatter(widget.maxLength),
          ]),
      ),
    );
  }
}
