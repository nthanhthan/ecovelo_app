import 'dart:async';

import 'package:ecoveloapp/app/core.dart';
import 'package:ecoveloapp/plugins/typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SearchInput<T> extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final void Function(String)? onChanged;
  final FutureOr<Iterable<T>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T) onSuggestionSelected;
  final String labelText;

  const SearchInput({
    Key? key,
    required this.searchController,
    required this.searchFocus,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.labelText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: AppColors.main.shade200,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    InputBorder searchOutLineBorder = OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.circular(16),
    );
    return TypeAheadFormField<T>(
      noItemsFoundBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: Row(
            children: [
              const Icon(
                Icons.warning_rounded,
                color: AppColors.main,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(S.of(context).noResultFound),
              ),
            ],
          ),
        );
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.grey.shade600),
      loadingBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 36,
            child: Center(
              child: ThreeBounceLoading(),
            ),
          ),
        );
      },
      keepSuggestionsOnLoading: false,
      textFieldConfiguration: TextFieldConfiguration(
        cursorColor: AppColors.main.shade300,
        cursorWidth: 3,
        controller: searchController,
        focusNode: searchFocus,
        style: textStyle,
        decoration: InputDecoration(
          fillColor: AppColors.white,
          counterText: '',
          hintText: labelText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.grey.shade300,
          ),
          filled: true,
          contentPadding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 10,
            bottom: 15,
          ),
          prefixIcon: SizedBox(
            height: 24,
            width: 24,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  AssetsConst.iconSearch,
                ),
              ],
            ),
          ),
          border: searchOutLineBorder,
          focusedBorder: searchOutLineBorder,
          enabledBorder: searchOutLineBorder,
          disabledBorder: searchOutLineBorder,
          errorBorder: searchOutLineBorder,
          focusedErrorBorder: searchOutLineBorder,
        ),
        onChanged: onChanged,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(emojisUnicodes))
        ],
      ),
      debounceDuration: const Duration(milliseconds: 500),
      suggestionsCallback: suggestionsCallback,
      itemBuilder: itemBuilder,
      onSuggestionSelected: onSuggestionSelected,
    );
  }
}
