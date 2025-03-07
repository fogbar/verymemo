// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_model.dart';

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
  String? get userId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
  List<ImageModel>? get imageUrls =>
      throw _privateConstructorUsedError; // 💡 nullable 처리
  @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
  List<LinkModel>? get links =>
      throw _privateConstructorUsedError; // 💡 nullable 처리
  @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
  List<TagModel>? get tags =>
      throw _privateConstructorUsedError; // 💡 nullable 처리
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int get isLocalMemo => throw _privateConstructorUsedError;

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
      String? userId,
      String content,
      @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
      List<ImageModel>? imageUrls,
      @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
      List<LinkModel>? links,
      @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
      List<TagModel>? tags,
      DateTime createdAt,
      DateTime? updatedAt,
      int isLocalMemo});

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
    Object? userId = freezed,
    Object? content = null,
    Object? imageUrls = freezed,
    Object? links = freezed,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isLocalMemo = null,
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
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
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
      isLocalMemo: null == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as int,
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
      String? userId,
      String content,
      @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
      List<ImageModel>? imageUrls,
      @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
      List<LinkModel>? links,
      @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
      List<TagModel>? tags,
      DateTime createdAt,
      DateTime? updatedAt,
      int isLocalMemo});

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
    Object? userId = freezed,
    Object? content = null,
    Object? imageUrls = freezed,
    Object? links = freezed,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isLocalMemo = null,
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
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
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
      isLocalMemo: null == isLocalMemo
          ? _value.isLocalMemo
          : isLocalMemo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$MemoModelImpl implements _MemoModel {
  const _$MemoModelImpl(
      {this.memoId,
      @JsonKey(ignore: true) this.user,
      this.userId,
      this.content = "",
      @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
      final List<ImageModel>? imageUrls,
      @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
      final List<LinkModel>? links,
      @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
      final List<TagModel>? tags,
      required this.createdAt,
      this.updatedAt,
      this.isLocalMemo = 1})
      : _imageUrls = imageUrls,
        _links = links,
        _tags = tags;

  @override
  final int? memoId;
  @override
  @JsonKey(ignore: true)
  final UserModel? user;
  @override
  final String? userId;
  @override
  @JsonKey()
  final String content;
  final List<ImageModel>? _imageUrls;
  @override
  @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
  List<ImageModel>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 💡 nullable 처리
  final List<LinkModel>? _links;
// 💡 nullable 처리
  @override
  @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
  List<LinkModel>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 💡 nullable 처리
  final List<TagModel>? _tags;
// 💡 nullable 처리
  @override
  @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
  List<TagModel>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 💡 nullable 처리
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final int isLocalMemo;

  @override
  String toString() {
    return 'MemoModel(memoId: $memoId, user: $user, userId: $userId, content: $content, imageUrls: $imageUrls, links: $links, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, isLocalMemo: $isLocalMemo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoModelImpl &&
            (identical(other.memoId, memoId) || other.memoId == memoId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isLocalMemo, isLocalMemo) ||
                other.isLocalMemo == isLocalMemo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      memoId,
      user,
      userId,
      content,
      const DeepCollectionEquality().hash(_imageUrls),
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt,
      isLocalMemo);

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
      final String? userId,
      final String content,
      @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
      final List<ImageModel>? imageUrls,
      @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
      final List<LinkModel>? links,
      @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
      final List<TagModel>? tags,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final int isLocalMemo}) = _$MemoModelImpl;

  @override
  int? get memoId;
  @override
  @JsonKey(ignore: true)
  UserModel? get user;
  @override
  String? get userId;
  @override
  String get content;
  @override
  @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
  List<ImageModel>? get imageUrls; // 💡 nullable 처리
  @override
  @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
  List<LinkModel>? get links; // 💡 nullable 처리
  @override
  @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
  List<TagModel>? get tags; // 💡 nullable 처리
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  int get isLocalMemo;

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoModelImplCopyWith<_$MemoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
