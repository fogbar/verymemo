// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dto.dart';

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
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt =>
      throw _privateConstructorUsedError; // @Default([]) List<ImageDTO>? images, // 💡 images 테이블과 연결
// @Default([]) List<LinkDTO>? links, // 💡 links 테이블과 연결
// @Default([]) List<TagDTO>? tags, // 💡 tags 테이블과 연결 (N:M 관계)
  int? get isLocalMemo => throw _privateConstructorUsedError; // 💡 0 또는 1
  int? get isBookMarked => throw _privateConstructorUsedError;

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
      String? createdAt,
      String? updatedAt,
      int? isLocalMemo,
      int? isBookMarked});
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
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isLocalMemo = freezed,
    Object? isBookMarked = freezed,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isLocalMemo: freezed == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as int?,
      isBookMarked: freezed == isBookMarked
          ? _value.isBookMarked
          : isBookMarked // ignore: cast_nullable_to_non_nullable
              as int?,
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
      String? createdAt,
      String? updatedAt,
      int? isLocalMemo,
      int? isBookMarked});
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
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isLocalMemo = freezed,
    Object? isBookMarked = freezed,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isLocalMemo: freezed == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as int?,
      isBookMarked: freezed == isBookMarked
          ? _value.isBookMarked
          : isBookMarked // ignore: cast_nullable_to_non_nullable
              as int?,
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
      this.createdAt,
      this.updatedAt,
      this.isLocalMemo,
      this.isBookMarked});

  @override
  final int? id;
  @override
  final String? userId;
  @override
  final String? content;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
// @Default([]) List<ImageDTO>? images, // 💡 images 테이블과 연결
// @Default([]) List<LinkDTO>? links, // 💡 links 테이블과 연결
// @Default([]) List<TagDTO>? tags, // 💡 tags 테이블과 연결 (N:M 관계)
  @override
  final int? isLocalMemo;
// 💡 0 또는 1
  @override
  final int? isBookMarked;

  @override
  String toString() {
    return 'MemoDTO(id: $id, userId: $userId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isLocalMemo: $isLocalMemo, isBookMarked: $isBookMarked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isLocalMemo, isLocalMemo) ||
                other.isLocalMemo == isLocalMemo) &&
            (identical(other.isBookMarked, isBookMarked) ||
                other.isBookMarked == isBookMarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, content, createdAt,
      updatedAt, isLocalMemo, isBookMarked);

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
      final String? createdAt,
      final String? updatedAt,
      final int? isLocalMemo,
      final int? isBookMarked}) = _$MemoDTOImpl;

  @override
  int? get id;
  @override
  String? get userId;
  @override
  String? get content;
  @override
  String? get createdAt;
  @override
  String?
      get updatedAt; // @Default([]) List<ImageDTO>? images, // 💡 images 테이블과 연결
// @Default([]) List<LinkDTO>? links, // 💡 links 테이블과 연결
// @Default([]) List<TagDTO>? tags, // 💡 tags 테이블과 연결 (N:M 관계)
  @override
  int? get isLocalMemo; // 💡 0 또는 1
  @override
  int? get isBookMarked;

  /// Create a copy of MemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoDTOImplCopyWith<_$MemoDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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

/// @nodoc
mixin _$LinkDTO {
  int? get id => throw _privateConstructorUsedError;
  int? get memoId => throw _privateConstructorUsedError; // 💡 외래키
  String get linkUrl =>
      throw _privateConstructorUsedError; // 💡 links 테이블의 url 컬럼
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
      String linkUrl,
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
    Object? linkUrl = null,
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
      linkUrl: null == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
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
      String linkUrl,
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
    Object? linkUrl = null,
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
      linkUrl: null == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
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
      required this.linkUrl,
      this.thumbnail,
      this.metaTitle,
      this.metaDescription});

  @override
  final int? id;
  @override
  final int? memoId;
// 💡 외래키
  @override
  final String linkUrl;
// 💡 links 테이블의 url 컬럼
  @override
  final String? thumbnail;
  @override
  final String? metaTitle;
  @override
  final String? metaDescription;

  @override
  String toString() {
    return 'LinkDTO(id: $id, memoId: $memoId, linkUrl: $linkUrl, thumbnail: $thumbnail, metaTitle: $metaTitle, metaDescription: $metaDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memoId, memoId) || other.memoId == memoId) &&
            (identical(other.linkUrl, linkUrl) || other.linkUrl == linkUrl) &&
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
      runtimeType, id, memoId, linkUrl, thumbnail, metaTitle, metaDescription);

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
      required final String linkUrl,
      final String? thumbnail,
      final String? metaTitle,
      final String? metaDescription}) = _$LinkDTOImpl;

  @override
  int? get id;
  @override
  int? get memoId; // 💡 외래키
  @override
  String get linkUrl; // 💡 links 테이블의 url 컬럼
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
