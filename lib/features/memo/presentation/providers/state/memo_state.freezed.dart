// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MemoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoStateCopyWith<$Res> {
  factory $MemoStateCopyWith(MemoState value, $Res Function(MemoState) then) =
      _$MemoStateCopyWithImpl<$Res, MemoState>;
}

/// @nodoc
class _$MemoStateCopyWithImpl<$Res, $Val extends MemoState>
    implements $MemoStateCopyWith<$Res> {
  _$MemoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MemoInitialImplCopyWith<$Res> {
  factory _$$MemoInitialImplCopyWith(
          _$MemoInitialImpl value, $Res Function(_$MemoInitialImpl) then) =
      __$$MemoInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemoInitialImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoInitialImpl>
    implements _$$MemoInitialImplCopyWith<$Res> {
  __$$MemoInitialImplCopyWithImpl(
      _$MemoInitialImpl _value, $Res Function(_$MemoInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MemoInitialImpl implements MemoInitial {
  const _$MemoInitialImpl();

  @override
  String toString() {
    return 'MemoState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MemoInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MemoInitial implements MemoState {
  const factory MemoInitial() = _$MemoInitialImpl;
}

/// @nodoc
abstract class _$$MemoLoadingImplCopyWith<$Res> {
  factory _$$MemoLoadingImplCopyWith(
          _$MemoLoadingImpl value, $Res Function(_$MemoLoadingImpl) then) =
      __$$MemoLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemoLoadingImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoLoadingImpl>
    implements _$$MemoLoadingImplCopyWith<$Res> {
  __$$MemoLoadingImplCopyWithImpl(
      _$MemoLoadingImpl _value, $Res Function(_$MemoLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MemoLoadingImpl implements MemoLoading {
  const _$MemoLoadingImpl();

  @override
  String toString() {
    return 'MemoState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MemoLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MemoLoading implements MemoState {
  const factory MemoLoading() = _$MemoLoadingImpl;
}

/// @nodoc
abstract class _$$MemoLoadedImplCopyWith<$Res> {
  factory _$$MemoLoadedImplCopyWith(
          _$MemoLoadedImpl value, $Res Function(_$MemoLoadedImpl) then) =
      __$$MemoLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Map<String, dynamic>> memos});
}

/// @nodoc
class __$$MemoLoadedImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoLoadedImpl>
    implements _$$MemoLoadedImplCopyWith<$Res> {
  __$$MemoLoadedImplCopyWithImpl(
      _$MemoLoadedImpl _value, $Res Function(_$MemoLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memos = null,
  }) {
    return _then(_$MemoLoadedImpl(
      null == memos
          ? _value._memos
          : memos // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

class _$MemoLoadedImpl implements MemoLoaded {
  const _$MemoLoadedImpl(final List<Map<String, dynamic>> memos)
      : _memos = memos;

  final List<Map<String, dynamic>> _memos;
  @override
  List<Map<String, dynamic>> get memos {
    if (_memos is EqualUnmodifiableListView) return _memos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memos);
  }

  @override
  String toString() {
    return 'MemoState.loaded(memos: $memos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoLoadedImpl &&
            const DeepCollectionEquality().equals(other._memos, _memos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_memos));

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoLoadedImplCopyWith<_$MemoLoadedImpl> get copyWith =>
      __$$MemoLoadedImplCopyWithImpl<_$MemoLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) {
    return loaded(memos);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) {
    return loaded?.call(memos);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(memos);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MemoLoaded implements MemoState {
  const factory MemoLoaded(final List<Map<String, dynamic>> memos) =
      _$MemoLoadedImpl;

  List<Map<String, dynamic>> get memos;

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoLoadedImplCopyWith<_$MemoLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MemoErrorImplCopyWith<$Res> {
  factory _$$MemoErrorImplCopyWith(
          _$MemoErrorImpl value, $Res Function(_$MemoErrorImpl) then) =
      __$$MemoErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MemoErrorImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoErrorImpl>
    implements _$$MemoErrorImplCopyWith<$Res> {
  __$$MemoErrorImplCopyWithImpl(
      _$MemoErrorImpl _value, $Res Function(_$MemoErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MemoErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MemoErrorImpl implements MemoError {
  const _$MemoErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MemoState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoErrorImplCopyWith<_$MemoErrorImpl> get copyWith =>
      __$$MemoErrorImplCopyWithImpl<_$MemoErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MemoError implements MemoState {
  const factory MemoError(final String message) = _$MemoErrorImpl;

  String get message;

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoErrorImplCopyWith<_$MemoErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MemoAddedImplCopyWith<$Res> {
  factory _$$MemoAddedImplCopyWith(
          _$MemoAddedImpl value, $Res Function(_$MemoAddedImpl) then) =
      __$$MemoAddedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemoAddedImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoAddedImpl>
    implements _$$MemoAddedImplCopyWith<$Res> {
  __$$MemoAddedImplCopyWithImpl(
      _$MemoAddedImpl _value, $Res Function(_$MemoAddedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MemoAddedImpl implements MemoAdded {
  const _$MemoAddedImpl();

  @override
  String toString() {
    return 'MemoState.added()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MemoAddedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) {
    return added();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) {
    return added?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }
}

abstract class MemoAdded implements MemoState {
  const factory MemoAdded() = _$MemoAddedImpl;
}

/// @nodoc
abstract class _$$MemoUpdatedImplCopyWith<$Res> {
  factory _$$MemoUpdatedImplCopyWith(
          _$MemoUpdatedImpl value, $Res Function(_$MemoUpdatedImpl) then) =
      __$$MemoUpdatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemoUpdatedImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoUpdatedImpl>
    implements _$$MemoUpdatedImplCopyWith<$Res> {
  __$$MemoUpdatedImplCopyWithImpl(
      _$MemoUpdatedImpl _value, $Res Function(_$MemoUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MemoUpdatedImpl implements MemoUpdated {
  const _$MemoUpdatedImpl();

  @override
  String toString() {
    return 'MemoState.updated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MemoUpdatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) {
    return updated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) {
    return updated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class MemoUpdated implements MemoState {
  const factory MemoUpdated() = _$MemoUpdatedImpl;
}

/// @nodoc
abstract class _$$MemoDeletedImplCopyWith<$Res> {
  factory _$$MemoDeletedImplCopyWith(
          _$MemoDeletedImpl value, $Res Function(_$MemoDeletedImpl) then) =
      __$$MemoDeletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemoDeletedImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoDeletedImpl>
    implements _$$MemoDeletedImplCopyWith<$Res> {
  __$$MemoDeletedImplCopyWithImpl(
      _$MemoDeletedImpl _value, $Res Function(_$MemoDeletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MemoDeletedImpl implements MemoDeleted {
  const _$MemoDeletedImpl();

  @override
  String toString() {
    return 'MemoState.deleted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MemoDeletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Map<String, dynamic>> memos) loaded,
    required TResult Function(String message) error,
    required TResult Function() added,
    required TResult Function() updated,
    required TResult Function() deleted,
  }) {
    return deleted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Map<String, dynamic>> memos)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? added,
    TResult? Function()? updated,
    TResult? Function()? deleted,
  }) {
    return deleted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Map<String, dynamic>> memos)? loaded,
    TResult Function(String message)? error,
    TResult Function()? added,
    TResult Function()? updated,
    TResult Function()? deleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemoInitial value) initial,
    required TResult Function(MemoLoading value) loading,
    required TResult Function(MemoLoaded value) loaded,
    required TResult Function(MemoError value) error,
    required TResult Function(MemoAdded value) added,
    required TResult Function(MemoUpdated value) updated,
    required TResult Function(MemoDeleted value) deleted,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemoInitial value)? initial,
    TResult? Function(MemoLoading value)? loading,
    TResult? Function(MemoLoaded value)? loaded,
    TResult? Function(MemoError value)? error,
    TResult? Function(MemoAdded value)? added,
    TResult? Function(MemoUpdated value)? updated,
    TResult? Function(MemoDeleted value)? deleted,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemoInitial value)? initial,
    TResult Function(MemoLoading value)? loading,
    TResult Function(MemoLoaded value)? loaded,
    TResult Function(MemoError value)? error,
    TResult Function(MemoAdded value)? added,
    TResult Function(MemoUpdated value)? updated,
    TResult Function(MemoDeleted value)? deleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class MemoDeleted implements MemoState {
  const factory MemoDeleted() = _$MemoDeletedImpl;
}
