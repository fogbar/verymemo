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

MemoModel _$MemoModelFromJson(Map<String, dynamic> json) {
  return _MemoModel.fromJson(json);
}

/// @nodoc
mixin _$MemoModel {
  UserModel? get user => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<ImageModel> get imageUrls => throw _privateConstructorUsedError;
  List<LinkDataModel> get links => throw _privateConstructorUsedError;
  List<TagModel> get tags => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isLocalMemo => throw _privateConstructorUsedError;

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
      {UserModel? user,
      String content,
      List<ImageModel> imageUrls,
      List<LinkDataModel> links,
      List<TagModel> tags,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isLocalMemo});

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
    Object? user = freezed,
    Object? content = null,
    Object? imageUrls = null,
    Object? links = null,
    Object? tags = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isLocalMemo = null,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkDataModel>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
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
      {UserModel? user,
      String content,
      List<ImageModel> imageUrls,
      List<LinkDataModel> links,
      List<TagModel> tags,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isLocalMemo});

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
    Object? user = freezed,
    Object? content = null,
    Object? imageUrls = null,
    Object? links = null,
    Object? tags = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isLocalMemo = null,
  }) {
    return _then(_$MemoModelImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<LinkDataModel>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
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
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoModelImpl implements _MemoModel {
  const _$MemoModelImpl(
      {this.user,
      this.content = "",
      final List<ImageModel> imageUrls = const [],
      final List<LinkDataModel> links = const [],
      final List<TagModel> tags = const [],
      required this.createdAt,
      this.updatedAt,
      this.isLocalMemo = false})
      : _imageUrls = imageUrls,
        _links = links,
        _tags = tags;

  factory _$MemoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoModelImplFromJson(json);

  @override
  final UserModel? user;
  @override
  @JsonKey()
  final String content;
  final List<ImageModel> _imageUrls;
  @override
  @JsonKey()
  List<ImageModel> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  final List<LinkDataModel> _links;
  @override
  @JsonKey()
  List<LinkDataModel> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final List<TagModel> _tags;
  @override
  @JsonKey()
  List<TagModel> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isLocalMemo;

  @override
  String toString() {
    return 'MemoModel(user: $user, content: $content, imageUrls: $imageUrls, links: $links, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, isLocalMemo: $isLocalMemo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoModelImpl &&
            (identical(other.user, user) || other.user == user) &&
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
      user,
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
      {final UserModel? user,
      final String content,
      final List<ImageModel> imageUrls,
      final List<LinkDataModel> links,
      final List<TagModel> tags,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final bool isLocalMemo}) = _$MemoModelImpl;

  factory _MemoModel.fromJson(Map<String, dynamic> json) =
      _$MemoModelImpl.fromJson;

  @override
  UserModel? get user;
  @override
  String get content;
  @override
  List<ImageModel> get imageUrls;
  @override
  List<LinkDataModel> get links;
  @override
  List<TagModel> get tags;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isLocalMemo;

  /// Create a copy of MemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoModelImplCopyWith<_$MemoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
