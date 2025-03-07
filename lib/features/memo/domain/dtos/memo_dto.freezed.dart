// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MemoDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  int? get isLocalMemo => throw _privateConstructorUsedError; // 💡 0 또는 1
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MemoDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoDTOCopyWith<MemoDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoDTOCopyWith<$Res> {
  factory $MemoDTOCopyWith(MemoDTO value, $Res Function(MemoDTO) then) =
      _$MemoDTOCopyWithImpl<$Res, MemoDTO>;
  @useResult
  $Res call(
      {int? id,
      String? userId,
      String? content,
      int? isLocalMemo,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$MemoDTOCopyWithImpl<$Res, $Val extends MemoDTO>
    implements $MemoDTOCopyWith<$Res> {
  _$MemoDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? content = freezed,
    Object? isLocalMemo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isLocalMemo: freezed == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemoDTOImplCopyWith<$Res> implements $MemoDTOCopyWith<$Res> {
  factory _$$MemoDTOImplCopyWith(
          _$MemoDTOImpl value, $Res Function(_$MemoDTOImpl) then) =
      __$$MemoDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? userId,
      String? content,
      int? isLocalMemo,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$$MemoDTOImplCopyWithImpl<$Res>
    extends _$MemoDTOCopyWithImpl<$Res, _$MemoDTOImpl>
    implements _$$MemoDTOImplCopyWith<$Res> {
  __$$MemoDTOImplCopyWithImpl(
      _$MemoDTOImpl _value, $Res Function(_$MemoDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? content = freezed,
    Object? isLocalMemo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MemoDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isLocalMemo: freezed == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$MemoDTOImpl implements _MemoDTO {
  const _$MemoDTOImpl(
      {this.id,
      this.userId,
      this.content,
      this.isLocalMemo,
      this.createdAt,
      this.updatedAt});

  @override
  final int? id;
  @override
  final String? userId;
  @override
  final String? content;
  @override
  final int? isLocalMemo;
// 💡 0 또는 1
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'MemoDTO(id: $id, userId: $userId, content: $content, isLocalMemo: $isLocalMemo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isLocalMemo, isLocalMemo) ||
                other.isLocalMemo == isLocalMemo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, content, isLocalMemo, createdAt, updatedAt);

  /// Create a copy of MemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoDTOImplCopyWith<_$MemoDTOImpl> get copyWith =>
      __$$MemoDTOImplCopyWithImpl<_$MemoDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoDTOImplToJson(
      this,
    );
  }
}

abstract class _MemoDTO implements MemoDTO {
  const factory _MemoDTO(
      {final int? id,
      final String? userId,
      final String? content,
      final int? isLocalMemo,
      final String? createdAt,
      final String? updatedAt}) = _$MemoDTOImpl;

  @override
  int? get id;
  @override
  String? get userId;
  @override
  String? get content;
  @override
  int? get isLocalMemo; // 💡 0 또는 1
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of MemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoDTOImplCopyWith<_$MemoDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
