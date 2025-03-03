// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LinkDataModel _$LinkDataModelFromJson(Map<String, dynamic> json) {
  return _LinkDataModel.fromJson(json);
}

/// @nodoc
mixin _$LinkDataModel {
  String get url => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  String get metaTitle => throw _privateConstructorUsedError;
  String get metaDescription => throw _privateConstructorUsedError;

  /// Serializes this LinkDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LinkDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkDataModelCopyWith<LinkDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkDataModelCopyWith<$Res> {
  factory $LinkDataModelCopyWith(
          LinkDataModel value, $Res Function(LinkDataModel) then) =
      _$LinkDataModelCopyWithImpl<$Res, LinkDataModel>;
  @useResult
  $Res call(
      {String url, String thumbnail, String metaTitle, String metaDescription});
}

/// @nodoc
class _$LinkDataModelCopyWithImpl<$Res, $Val extends LinkDataModel>
    implements $LinkDataModelCopyWith<$Res> {
  _$LinkDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? thumbnail = null,
    Object? metaTitle = null,
    Object? metaDescription = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      metaTitle: null == metaTitle
          ? _value.metaTitle
          : metaTitle // ignore: cast_nullable_to_non_nullable
              as String,
      metaDescription: null == metaDescription
          ? _value.metaDescription
          : metaDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkDataModelImplCopyWith<$Res>
    implements $LinkDataModelCopyWith<$Res> {
  factory _$$LinkDataModelImplCopyWith(
          _$LinkDataModelImpl value, $Res Function(_$LinkDataModelImpl) then) =
      __$$LinkDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url, String thumbnail, String metaTitle, String metaDescription});
}

/// @nodoc
class __$$LinkDataModelImplCopyWithImpl<$Res>
    extends _$LinkDataModelCopyWithImpl<$Res, _$LinkDataModelImpl>
    implements _$$LinkDataModelImplCopyWith<$Res> {
  __$$LinkDataModelImplCopyWithImpl(
      _$LinkDataModelImpl _value, $Res Function(_$LinkDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? thumbnail = null,
    Object? metaTitle = null,
    Object? metaDescription = null,
  }) {
    return _then(_$LinkDataModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      metaTitle: null == metaTitle
          ? _value.metaTitle
          : metaTitle // ignore: cast_nullable_to_non_nullable
              as String,
      metaDescription: null == metaDescription
          ? _value.metaDescription
          : metaDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkDataModelImpl implements _LinkDataModel {
  const _$LinkDataModelImpl(
      {required this.url,
      this.thumbnail = "",
      this.metaTitle = "",
      this.metaDescription = ""});

  factory _$LinkDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkDataModelImplFromJson(json);

  @override
  final String url;
  @override
  @JsonKey()
  final String thumbnail;
  @override
  @JsonKey()
  final String metaTitle;
  @override
  @JsonKey()
  final String metaDescription;

  @override
  String toString() {
    return 'LinkDataModel(url: $url, thumbnail: $thumbnail, metaTitle: $metaTitle, metaDescription: $metaDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkDataModelImpl &&
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
  int get hashCode =>
      Object.hash(runtimeType, url, thumbnail, metaTitle, metaDescription);

  /// Create a copy of LinkDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkDataModelImplCopyWith<_$LinkDataModelImpl> get copyWith =>
      __$$LinkDataModelImplCopyWithImpl<_$LinkDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkDataModelImplToJson(
      this,
    );
  }
}

abstract class _LinkDataModel implements LinkDataModel {
  const factory _LinkDataModel(
      {required final String url,
      final String thumbnail,
      final String metaTitle,
      final String metaDescription}) = _$LinkDataModelImpl;

  factory _LinkDataModel.fromJson(Map<String, dynamic> json) =
      _$LinkDataModelImpl.fromJson;

  @override
  String get url;
  @override
  String get thumbnail;
  @override
  String get metaTitle;
  @override
  String get metaDescription;

  /// Create a copy of LinkDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkDataModelImplCopyWith<_$LinkDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
