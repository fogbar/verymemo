// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LinkDTO {
  int? get id => throw _privateConstructorUsedError;
  int? get memoId => throw _privateConstructorUsedError; // 💡 외래키
  String get url => throw _privateConstructorUsedError; // 💡 links 테이블의 url 컬럼
  String? get thumbnail => throw _privateConstructorUsedError;
  String? get metaTitle => throw _privateConstructorUsedError;
  String? get metaDescription => throw _privateConstructorUsedError;

  /// Serializes this LinkDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LinkDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkDTOCopyWith<LinkDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkDTOCopyWith<$Res> {
  factory $LinkDTOCopyWith(LinkDTO value, $Res Function(LinkDTO) then) =
      _$LinkDTOCopyWithImpl<$Res, LinkDTO>;
  @useResult
  $Res call(
      {int? id,
      int? memoId,
      String url,
      String? thumbnail,
      String? metaTitle,
      String? metaDescription});
}

/// @nodoc
class _$LinkDTOCopyWithImpl<$Res, $Val extends LinkDTO>
    implements $LinkDTOCopyWith<$Res> {
  _$LinkDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memoId = freezed,
    Object? url = null,
    Object? thumbnail = freezed,
    Object? metaTitle = freezed,
    Object? metaDescription = freezed,
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
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      metaTitle: freezed == metaTitle
          ? _value.metaTitle
          : metaTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      metaDescription: freezed == metaDescription
          ? _value.metaDescription
          : metaDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkDTOImplCopyWith<$Res> implements $LinkDTOCopyWith<$Res> {
  factory _$$LinkDTOImplCopyWith(
          _$LinkDTOImpl value, $Res Function(_$LinkDTOImpl) then) =
      __$$LinkDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? memoId,
      String url,
      String? thumbnail,
      String? metaTitle,
      String? metaDescription});
}

/// @nodoc
class __$$LinkDTOImplCopyWithImpl<$Res>
    extends _$LinkDTOCopyWithImpl<$Res, _$LinkDTOImpl>
    implements _$$LinkDTOImplCopyWith<$Res> {
  __$$LinkDTOImplCopyWithImpl(
      _$LinkDTOImpl _value, $Res Function(_$LinkDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memoId = freezed,
    Object? url = null,
    Object? thumbnail = freezed,
    Object? metaTitle = freezed,
    Object? metaDescription = freezed,
  }) {
    return _then(_$LinkDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      memoId: freezed == memoId
          ? _value.memoId
          : memoId // ignore: cast_nullable_to_non_nullable
              as int?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      metaTitle: freezed == metaTitle
          ? _value.metaTitle
          : metaTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      metaDescription: freezed == metaDescription
          ? _value.metaDescription
          : metaDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$LinkDTOImpl implements _LinkDTO {
  const _$LinkDTOImpl(
      {this.id,
      this.memoId,
      required this.url,
      this.thumbnail,
      this.metaTitle,
      this.metaDescription});

  @override
  final int? id;
  @override
  final int? memoId;
// 💡 외래키
  @override
  final String url;
// 💡 links 테이블의 url 컬럼
  @override
  final String? thumbnail;
  @override
  final String? metaTitle;
  @override
  final String? metaDescription;

  @override
  String toString() {
    return 'LinkDTO(id: $id, memoId: $memoId, url: $url, thumbnail: $thumbnail, metaTitle: $metaTitle, metaDescription: $metaDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memoId, memoId) || other.memoId == memoId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.metaTitle, metaTitle) ||
                other.metaTitle == metaTitle) &&
            (identical(other.metaDescription, metaDescription) ||
                other.metaDescription == metaDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, memoId, url, thumbnail, metaTitle, metaDescription);

  /// Create a copy of LinkDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkDTOImplCopyWith<_$LinkDTOImpl> get copyWith =>
      __$$LinkDTOImplCopyWithImpl<_$LinkDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkDTOImplToJson(
      this,
    );
  }
}

abstract class _LinkDTO implements LinkDTO {
  const factory _LinkDTO(
      {final int? id,
      final int? memoId,
      required final String url,
      final String? thumbnail,
      final String? metaTitle,
      final String? metaDescription}) = _$LinkDTOImpl;

  @override
  int? get id;
  @override
  int? get memoId; // 💡 외래키
  @override
  String get url; // 💡 links 테이블의 url 컬럼
  @override
  String? get thumbnail;
  @override
  String? get metaTitle;
  @override
  String? get metaDescription;

  /// Create a copy of LinkDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkDTOImplCopyWith<_$LinkDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
