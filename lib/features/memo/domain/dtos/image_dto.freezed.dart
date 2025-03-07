// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageDTO {
  int? get id => throw _privateConstructorUsedError;
  int? get memoId => throw _privateConstructorUsedError; // 💡 외래키
  String get imageUrl =>
      throw _privateConstructorUsedError; // 💡 images 테이블의 imageUrl 컬럼
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ImageDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageDTOCopyWith<ImageDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDTOCopyWith<$Res> {
  factory $ImageDTOCopyWith(ImageDTO value, $Res Function(ImageDTO) then) =
      _$ImageDTOCopyWithImpl<$Res, ImageDTO>;
  @useResult
  $Res call({int? id, int? memoId, String imageUrl, String? description});
}

/// @nodoc
class _$ImageDTOCopyWithImpl<$Res, $Val extends ImageDTO>
    implements $ImageDTOCopyWith<$Res> {
  _$ImageDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memoId = freezed,
    Object? imageUrl = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      memoId: freezed == memoId
          ? _value.memoId
          : memoId // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageDTOImplCopyWith<$Res>
    implements $ImageDTOCopyWith<$Res> {
  factory _$$ImageDTOImplCopyWith(
          _$ImageDTOImpl value, $Res Function(_$ImageDTOImpl) then) =
      __$$ImageDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int? memoId, String imageUrl, String? description});
}

/// @nodoc
class __$$ImageDTOImplCopyWithImpl<$Res>
    extends _$ImageDTOCopyWithImpl<$Res, _$ImageDTOImpl>
    implements _$$ImageDTOImplCopyWith<$Res> {
  __$$ImageDTOImplCopyWithImpl(
      _$ImageDTOImpl _value, $Res Function(_$ImageDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memoId = freezed,
    Object? imageUrl = null,
    Object? description = freezed,
  }) {
    return _then(_$ImageDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      memoId: freezed == memoId
          ? _value.memoId
          : memoId // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$ImageDTOImpl implements _ImageDTO {
  const _$ImageDTOImpl(
      {this.id, this.memoId, required this.imageUrl, this.description});

  @override
  final int? id;
  @override
  final int? memoId;
// 💡 외래키
  @override
  final String imageUrl;
// 💡 images 테이블의 imageUrl 컬럼
  @override
  final String? description;

  @override
  String toString() {
    return 'ImageDTO(id: $id, memoId: $memoId, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memoId, memoId) || other.memoId == memoId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, memoId, imageUrl, description);

  /// Create a copy of ImageDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageDTOImplCopyWith<_$ImageDTOImpl> get copyWith =>
      __$$ImageDTOImplCopyWithImpl<_$ImageDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageDTOImplToJson(
      this,
    );
  }
}

abstract class _ImageDTO implements ImageDTO {
  const factory _ImageDTO(
      {final int? id,
      final int? memoId,
      required final String imageUrl,
      final String? description}) = _$ImageDTOImpl;

  @override
  int? get id;
  @override
  int? get memoId; // 💡 외래키
  @override
  String get imageUrl; // 💡 images 테이블의 imageUrl 컬럼
  @override
  String? get description;

  /// Create a copy of ImageDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageDTOImplCopyWith<_$ImageDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
