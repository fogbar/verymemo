// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionState {
  bool get allAgree => throw _privateConstructorUsedError; // 필수 체크 토글 상태
  bool get allGranted => throw _privateConstructorUsedError; // 모든 권한 허용 여부
  Map<PermissionType, bool> get permissions =>
      throw _privateConstructorUsedError;

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionStateCopyWith<PermissionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionStateCopyWith<$Res> {
  factory $PermissionStateCopyWith(
          PermissionState value, $Res Function(PermissionState) then) =
      _$PermissionStateCopyWithImpl<$Res, PermissionState>;
  @useResult
  $Res call(
      {bool allAgree, bool allGranted, Map<PermissionType, bool> permissions});
}

/// @nodoc
class _$PermissionStateCopyWithImpl<$Res, $Val extends PermissionState>
    implements $PermissionStateCopyWith<$Res> {
  _$PermissionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allAgree = null,
    Object? allGranted = null,
    Object? permissions = null,
  }) {
    return _then(_value.copyWith(
      allAgree: null == allAgree
          ? _value.allAgree
          : allAgree // ignore: cast_nullable_to_non_nullable
              as bool,
      allGranted: null == allGranted
          ? _value.allGranted
          : allGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as Map<PermissionType, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionStateImplCopyWith<$Res>
    implements $PermissionStateCopyWith<$Res> {
  factory _$$PermissionStateImplCopyWith(_$PermissionStateImpl value,
          $Res Function(_$PermissionStateImpl) then) =
      __$$PermissionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool allAgree, bool allGranted, Map<PermissionType, bool> permissions});
}

/// @nodoc
class __$$PermissionStateImplCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res, _$PermissionStateImpl>
    implements _$$PermissionStateImplCopyWith<$Res> {
  __$$PermissionStateImplCopyWithImpl(
      _$PermissionStateImpl _value, $Res Function(_$PermissionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allAgree = null,
    Object? allGranted = null,
    Object? permissions = null,
  }) {
    return _then(_$PermissionStateImpl(
      allAgree: null == allAgree
          ? _value.allAgree
          : allAgree // ignore: cast_nullable_to_non_nullable
              as bool,
      allGranted: null == allGranted
          ? _value.allGranted
          : allGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as Map<PermissionType, bool>,
    ));
  }
}

/// @nodoc

class _$PermissionStateImpl implements _PermissionState {
  const _$PermissionStateImpl(
      {this.allAgree = false,
      this.allGranted = false,
      final Map<PermissionType, bool> permissions = const {}})
      : _permissions = permissions;

  @override
  @JsonKey()
  final bool allAgree;
// 필수 체크 토글 상태
  @override
  @JsonKey()
  final bool allGranted;
// 모든 권한 허용 여부
  final Map<PermissionType, bool> _permissions;
// 모든 권한 허용 여부
  @override
  @JsonKey()
  Map<PermissionType, bool> get permissions {
    if (_permissions is EqualUnmodifiableMapView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_permissions);
  }

  @override
  String toString() {
    return 'PermissionState(allAgree: $allAgree, allGranted: $allGranted, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionStateImpl &&
            (identical(other.allAgree, allAgree) ||
                other.allAgree == allAgree) &&
            (identical(other.allGranted, allGranted) ||
                other.allGranted == allGranted) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, allAgree, allGranted,
      const DeepCollectionEquality().hash(_permissions));

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionStateImplCopyWith<_$PermissionStateImpl> get copyWith =>
      __$$PermissionStateImplCopyWithImpl<_$PermissionStateImpl>(
          this, _$identity);
}

abstract class _PermissionState implements PermissionState {
  const factory _PermissionState(
      {final bool allAgree,
      final bool allGranted,
      final Map<PermissionType, bool> permissions}) = _$PermissionStateImpl;

  @override
  bool get allAgree; // 필수 체크 토글 상태
  @override
  bool get allGranted; // 모든 권한 허용 여부
  @override
  Map<PermissionType, bool> get permissions;

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionStateImplCopyWith<_$PermissionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
