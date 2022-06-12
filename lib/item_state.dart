import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'item_state.freezed.dart';
part 'item_state.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ItemState with _$ItemState {
  const factory ItemState({
    required final String name,
    required final List<String> innerItemList,
  }) = _ItemState;
  factory ItemState.fromJson(Map<String, Object?> json) =>
      _$ItemStateFromJson(json);
}
