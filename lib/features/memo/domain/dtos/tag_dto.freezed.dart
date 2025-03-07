// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TagDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get tagName => throw _privateConstructorUsedError;

  /// Serializes this TagDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagDTOCopyWith<TagDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagDTOCopyWith<$Res> {
  factory $TagDTOCopyWith(TagDTO value, $Res Function(TagDTO) then) =
      _$TagDTOCopyWithImpl<$Res, TagDTO>;
  @useResult
  $Res call({int? id, String? tagName});
}

/// @nodoc
class _$TagDTOCopyWithImpl<$Res, $Val extends TagDTO>
    implements $TagDTOCopyWith<$Res> {
  _$TagDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tagName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tagName: freezed == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagDTOImplCopyWith<$Res> implements $TagDTOCopyWith<$Res> {
  factory _$$TagDTOImplCopyWith(
          _$TagDTOImpl value, $Res Function(_$TagDTOImpl) then) =
      __$$TagDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? tagName});
}

/// @nodoc
class __$$TagDTOImplCopyWithImpl<$Res>
    extends _$TagDTOCopyWithImpl<$Res, _$TagDTOImpl>
    implements _$$TagDTOImplCopyWith<$Res> {
  __$$TagDTOImplCopyWithImpl(
      _$TagDTOImpl _value, $Res Function(_$TagDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tagName = freezed,
  }) {
    return _then(_$TagDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tagName: freezed == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$TagDTOImpl implements _TagDTO {
  const _$TagDTOImpl({this.id, this.tagName});

  @override
  final int? id;
  @override
  final String? tagName;

  @override
  String toString() {
    return 'TagDTO(id: $id, tagName: $tagName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tagName, tagName) || other.tagName == tagName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, tagName);

  /// Create a copy of TagDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagDTOImplCopyWith<_$TagDTOImpl> get copyWith =>
      __$$TagDTOImplCopyWithImpl<_$TagDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagDTOImplToJson(
      this,
    );
  }
}

abstract class _TagDTO implements TagDTO {
  const factory _TagDTO({final int? id, final String? tagName}) = _$TagDTOImpl;

  @override
  int? get id;
  @override
  String? get tagName;

  /// Create a copy of TagDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagDTOImplCopyWith<_$TagDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
