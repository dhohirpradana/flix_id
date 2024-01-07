import 'package:flix_id/presentation/misc/method.dart';
import 'package:flix_id/presentation/widgets/selectable_card.dart';
import 'package:flutter/material.dart';

List<Widget> options<T>({
  required String title,
  required List<T> options,
  required T? selectedOption,
  String Function(T option)? optionToString,
  bool Function(T option)? isOptionEnabled,
  required void Function(T option) onOptionTap,
}) =>
    [
      Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
      verticalSpace(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: e == options.first ? 24 : 0,
                      right: e == options.last ? 24 : 10),
                  child: SelectableCard(
                      text: optionToString != null
                          ? optionToString(e)
                          : e.toString(),
                      isSelected: e == selectedOption,
                      isEnable: isOptionEnabled?.call(e) ?? true,
                      onTap: () => onOptionTap(e)),
                ),
              )
              .toList(),
        ),
      )
    ];
