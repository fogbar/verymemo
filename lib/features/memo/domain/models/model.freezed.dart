// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MemoModel {
  int? get memoId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  UserModel? get user => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<ImageModel>? get images => throw _privateConstructorUsedError;
  List<LinkModel>? get links => throw _privateConstructorUsedError;
  List<TagModel>? get tags => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastViewedAt => throw _privateConstructorUsedError;
  bool get isLocalMemo => throw _privateConstructorUsedError;
  bool get isBookMarked => throw _privateConstructorUsedError;

  /// Serializes this MemoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoModelCopyWith<MemoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoModelCopyWith<$Res> {
  factory $MemoModelCopyWith(MemoModel value, $Res Function(MemoModel) then) =
      _$MemoModelCopyWithImpl<$Res, MemoModel>;
  @useResult
  $Res call(
      {int? memoId,
      @JsonKey(ignore: true) UserModel? user,
      String? profileImageUrl,
      String? userId,
      String? userName,
      String? content,
      List<ImageModel>? images,
      List<LinkModel>? links,
      List<TagModel>? tags,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? lastViewedAt,
      bool isLocalMemo,
      bool isBookMarked});

  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$MemoModelCopyWithImpl<$Res, $Val extends MemoModel>
    implements $MemoModelCopyWith<$Res> {
  _$MemoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoId = freezed,
    Object? user = freezed,
    Object? profileImageUrl = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? content = freezed,
    Object? images = freezed,
    Object? links = freezed,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastViewedAt = freezed,
    Object? isLocalMemo = null,
    Object? isBookMarked = null,
  }) {
    return _then(_value.copyWith(
      memoId: freezed == memoId
          ? _value.memoId
          : memoId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkModel>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastViewedAt: freezed == lastViewedAt
          ? _value.lastViewedAt
          : lastViewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLocalMemo: null == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as bool,
      isBookMarked: null == isBookMarked
          ? _value.isBookMarked
          : isBookMarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MemoModelImplCopyWith<$Res>
    implements $MemoModelCopyWith<$Res> {
  factory _$$MemoModelImplCopyWith(
          _$MemoModelImpl value, $Res Function(_$MemoModelImpl) then) =
      __$$MemoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? memoId,
      @JsonKey(ignore: true) UserModel? user,
      String? profileImageUrl,
      String? userId,
      String? userName,
      String? content,
      List<ImageModel>? images,
      List<LinkModel>? links,
      List<TagModel>? tags,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? lastViewedAt,
      bool isLocalMemo,
      bool isBookMarked});

  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$MemoModelImplCopyWithImpl<$Res>
    extends _$MemoModelCopyWithImpl<$Res, _$MemoModelImpl>
    implements _$$MemoModelImplCopyWith<$Res> {
  __$$MemoModelImplCopyWithImpl(
      _$MemoModelImpl _value, $Res Function(_$MemoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoId = freezed,
    Object? user = freezed,
    Object? profileImageUrl = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? content = freezed,
    Object? images = freezed,
    Object? links = freezed,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastViewedAt = freezed,
    Object? isLocalMemo = null,
    Object? isBookMarked = null,
  }) {
    return _then(_$MemoModelImpl(
      memoId: freezed == memoId
          ? _value.memoId
          : memoId // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkModel>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastViewedAt: freezed == lastViewedAt
          ? _value.lastViewedAt
          : lastViewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLocalMemo: null == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as bool,
      isBookMarked: null == isBookMarked
          ? _value.isBookMarked
          : isBookMarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$MemoModelImpl implements _MemoModel {
  const _$MemoModelImpl(
      {this.memoId,
      @JsonKey(ignore: true) this.user,
      this.profileImageUrl,
      this.userId,
      this.userName,
      this.content,
      final List<ImageModel>? images,
      final List<LinkModel>? links,
      final List<TagModel>? tags,
      required this.createdAt,
      this.updatedAt,
      this.lastViewedAt,
      this.isLocalMemo = false,
      this.isBookMarked = false})
      : _images = images,
        _links = links,
        _tags = tags;

  @override
  final int? memoId;
  @override
  @JsonKey(ignore: true)
  final UserModel? user;
  @override
  final String? profileImageUrl;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final String? content;
  final List<ImageModel>? _images;
  @override
  List<ImageModel>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<LinkModel>? _links;
  @override
  List<LinkModel>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TagModel>? _tags;
  @override
  List<TagModel>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastViewedAt;
  @override
  @JsonKey()
  final bool isLocalMemo;
  @override
  @JsonKey()
  final bool isBookMarked;

  @override
  String toString() {
    return 'MemoModel(memoId: $memoId, user: $user, profileImageUrl: $profileImageUrl, userId: $userId, userName: $userName, content: $content, images: $images, links: $links, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, lastViewedAt: $lastViewedAt, isLocalMemo: $isLocalMemo, isBookMarked: $isBookMarked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoModelImpl &&
            (identical(other.memoId, memoId) || other.memoId == memoId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastViewedAt, lastViewedAt) ||
                other.lastViewedAt == lastViewedAt) &&
            (identical(other.isLocalMemo, isLocalMemo) ||
                other.isLocalMemo == isLocalMemo) &&
            (identical(other.isBookMarked, isBookMarked) ||
                other.isBookMarked == isBookMarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      memoId,
      user,
      profileImageUrl,
      userId,
      userName,
      content,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt,
      lastViewedAt,
      isLocalMemo,
      isBookMarked);

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoModelImplCopyWith<_$MemoModelImpl> get copyWith =>
      __$$MemoModelImplCopyWithImpl<_$MemoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoModelImplToJson(
      this,
    );
  }
}

abstract class _MemoModel implements MemoModel {
  const factory _MemoModel(
      {final int? memoId,
      @JsonKey(ignore: true) final UserModel? user,
      final String? profileImageUrl,
      final String? userId,
      final String? userName,
      final String? content,
      final List<ImageModel>? images,
      final List<LinkModel>? links,
      final List<TagModel>? tags,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? lastViewedAt,
      final bool isLocalMemo,
      final bool isBookMarked}) = _$MemoModelImpl;

  @override
  int? get memoId;
  @override
  @JsonKey(ignore: true)
  UserModel? get user;
  @override
  String? get profileImageUrl;
  @override
  String? get userId;
  @override
  String? get userName;
  @override
  String? get content;
  @override
  List<ImageModel>? get images;
  @override
  List<LinkModel>? get links;
  @override
  List<TagModel>? get tags;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastViewedAt;
  @override
  bool get isLocalMemo;
  @override
  bool get isBookMarked;

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoModelImplCopyWith<_$MemoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LinkModel {
  int? get linkId => throw _privateConstructorUsedError;
  String? get linkUrl => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;
  String? get metaTitle => throw _privateConstructorUsedError;
  String? get metaDescription => throw _privateConstructorUsedError;

  /// Serializes this LinkModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LinkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkModelCopyWith<LinkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkModelCopyWith<$Res> {
  factory $LinkModelCopyWith(LinkModel value, $Res Function(LinkModel) then) =
      _$LinkModelCopyWithImpl<$Res, LinkModel>;
  @useResult
  $Res call(
      {int? linkId,
      String? linkUrl,
      String? thumbnail,
      String? metaTitle,
      String? metaDescription});
}

/// @nodoc
class _$LinkModelCopyWithImpl<$Res, $Val extends LinkModel>
    implements $LinkModelCopyWith<$Res> {
  _$LinkModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? linkId = freezed,
    Object? linkUrl = freezed,
    Object? thumbnail = freezed,
    Object? metaTitle = freezed,
    Object? metaDescription = freezed,
  }) {
    return _then(_value.copyWith(
      linkId: freezed == linkId
          ? _value.linkId
          : linkId // ignore: cast_nullable_to_non_nullable
              as int?,
      linkUrl: freezed == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$LinkModelImplCopyWith<$Res>
    implements $LinkModelCopyWith<$Res> {
  factory _$$LinkModelImplCopyWith(
          _$LinkModelImpl value, $Res Function(_$LinkModelImpl) then) =
      __$$LinkModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? linkId,
      String? linkUrl,
      String? thumbnail,
      String? metaTitle,
      String? metaDescription});
}

/// @nodoc
class __$$LinkModelImplCopyWithImpl<$Res>
    extends _$LinkModelCopyWithImpl<$Res, _$LinkModelImpl>
    implements _$$LinkModelImplCopyWith<$Res> {
  __$$LinkModelImplCopyWithImpl(
      _$LinkModelImpl _value, $Res Function(_$LinkModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? linkId = freezed,
    Object? linkUrl = freezed,
    Object? thumbnail = freezed,
    Object? metaTitle = freezed,
    Object? metaDescription = freezed,
  }) {
    return _then(_$LinkModelImpl(
      linkId: freezed == linkId
          ? _value.linkId
          : linkId // ignore: cast_nullable_to_non_nullable
              as int?,
      linkUrl: freezed == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$LinkModelImpl implements _LinkModel {
  const _$LinkModelImpl(
      {this.linkId,
      this.linkUrl = "",
      this.thumbnail = "",
      this.metaTitle = "",
      this.metaDescription = ""});

  @override
  final int? linkId;
  @override
  @JsonKey()
  final String? linkUrl;
  @override
  @JsonKey()
  final String? thumbnail;
  @override
  @JsonKey()
  final String? metaTitle;
  @override
  @JsonKey()
  final String? metaDescription;

  @override
  String toString() {
    return 'LinkModel(linkId: $linkId, linkUrl: $linkUrl, thumbnail: $thumbnail, metaTitle: $metaTitle, metaDescription: $metaDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkModelImpl &&
            (identical(other.linkId, linkId) || other.linkId == linkId) &&
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
      runtimeType, linkId, linkUrl, thumbnail, metaTitle, metaDescription);

  /// Create a copy of LinkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkModelImplCopyWith<_$LinkModelImpl> get copyWith =>
      __$$LinkModelImplCopyWithImpl<_$LinkModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkModelImplToJson(
      this,
    );
  }
}

abstract class _LinkModel implements LinkModel {
  const factory _LinkModel(
      {final int? linkId,
      final String? linkUrl,
      final String? thumbnail,
      final String? metaTitle,
      final String? metaDescription}) = _$LinkModelImpl;

  @override
  int? get linkId;
  @override
  String? get linkUrl;
  @override
  String? get thumbnail;
  @override
  String? get metaTitle;
  @override
  String? get metaDescription;

  /// Create a copy of LinkModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkModelImplCopyWith<_$LinkModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ImageModel {
  int? get imageId => throw _privateConstructorUsedError; // 해당 image의 인덱스
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ImageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageModelCopyWith<ImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageModelCopyWith<$Res> {
  factory $ImageModelCopyWith(
          ImageModel value, $Res Function(ImageModel) then) =
      _$ImageModelCopyWithImpl<$Res, ImageModel>;
  @useResult
  $Res call({int? imageId, String? imageUrl, String? description});
}

/// @nodoc
class _$ImageModelCopyWithImpl<$Res, $Val extends ImageModel>
    implements $ImageModelCopyWith<$Res> {
  _$ImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageId = freezed,
    Object? imageUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      imageId: freezed == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageModelImplCopyWith<$Res>
    implements $ImageModelCopyWith<$Res> {
  factory _$$ImageModelImplCopyWith(
          _$ImageModelImpl value, $Res Function(_$ImageModelImpl) then) =
      __$$ImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? imageId, String? imageUrl, String? description});
}

/// @nodoc
class __$$ImageModelImplCopyWithImpl<$Res>
    extends _$ImageModelCopyWithImpl<$Res, _$ImageModelImpl>
    implements _$$ImageModelImplCopyWith<$Res> {
  __$$ImageModelImplCopyWithImpl(
      _$ImageModelImpl _value, $Res Function(_$ImageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageId = freezed,
    Object? imageUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(_$ImageModelImpl(
      imageId: freezed == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$ImageModelImpl implements _ImageModel {
  const _$ImageModelImpl(
      {this.imageId, this.imageUrl = "", this.description = ""});

  @override
  final int? imageId;
// 해당 image의 인덱스
  @override
  @JsonKey()
  final String? imageUrl;
  @override
  @JsonKey()
  final String? description;

  @override
  String toString() {
    return 'ImageModel(imageId: $imageId, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageModelImpl &&
            (identical(other.imageId, imageId) || other.imageId == imageId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, imageId, imageUrl, description);

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageModelImplCopyWith<_$ImageModelImpl> get copyWith =>
      __$$ImageModelImplCopyWithImpl<_$ImageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageModelImplToJson(
      this,
    );
  }
}

abstract class _ImageModel implements ImageModel {
  const factory _ImageModel(
      {final int? imageId,
      final String? imageUrl,
      final String? description}) = _$ImageModelImpl;

  @override
  int? get imageId; // 해당 image의 인덱스
  @override
  String? get imageUrl;
  @override
  String? get description;

  /// Create a copy of ImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageModelImplCopyWith<_$ImageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return _TagModel.fromJson(json);
}

/// @nodoc
mixin _$TagModel {
  String? get tagName => throw _privateConstructorUsedError;

  /// Serializes this TagModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagModelCopyWith<TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagModelCopyWith<$Res> {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) then) =
      _$TagModelCopyWithImpl<$Res, TagModel>;
  @useResult
  $Res call({String? tagName});
}

/// @nodoc
class _$TagModelCopyWithImpl<$Res, $Val extends TagModel>
    implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagName = freezed,
  }) {
    return _then(_value.copyWith(
      tagName: freezed == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagModelImplCopyWith<$Res>
    implements $TagModelCopyWith<$Res> {
  factory _$$TagModelImplCopyWith(
          _$TagModelImpl value, $Res Function(_$TagModelImpl) then) =
      __$$TagModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? tagName});
}

/// @nodoc
class __$$TagModelImplCopyWithImpl<$Res>
    extends _$TagModelCopyWithImpl<$Res, _$TagModelImpl>
    implements _$$TagModelImplCopyWith<$Res> {
  __$$TagModelImplCopyWithImpl(
      _$TagModelImpl _value, $Res Function(_$TagModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagName = freezed,
  }) {
    return _then(_$TagModelImpl(
      tagName: freezed == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagModelImpl implements _TagModel {
  const _$TagModelImpl({this.tagName});

  factory _$TagModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagModelImplFromJson(json);

  @override
  final String? tagName;

  @override
  String toString() {
    return 'TagModel(tagName: $tagName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagModelImpl &&
            (identical(other.tagName, tagName) || other.tagName == tagName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tagName);

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagModelImplCopyWith<_$TagModelImpl> get copyWith =>
      __$$TagModelImplCopyWithImpl<_$TagModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagModelImplToJson(
      this,
    );
  }
}

abstract class _TagModel implements TagModel {
  const factory _TagModel({final String? tagName}) = _$TagModelImpl;

  factory _TagModel.fromJson(Map<String, dynamic> json) =
      _$TagModelImpl.fromJson;

  @override
  String? get tagName;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagModelImplCopyWith<_$TagModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
