import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'writing_provider.g.dart';

@riverpod
class WritingState extends _$WritingState {
  @override
  bool build() => false;

  void toggle() => state = !state;
} 