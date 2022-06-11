import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'item.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ItemState with _$ItemState {
  const factory ItemState({
    required final String name,
    required final List<String> innerItemList,
  }) = _ItemState;
}
