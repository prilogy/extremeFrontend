class FcmTokenRefreshModel {
  /// Returns a new [FcmTokenRefreshModel] instance.
  FcmTokenRefreshModel({
    this.newToken,
    this.oldToken,
  });

  String? newToken;

  String? oldToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FcmTokenRefreshModel &&
      other.newToken == newToken &&
      other.oldToken == oldToken;

  @override
  int get hashCode =>
      (newToken == null ? 0 : newToken.hashCode) +
          (oldToken == null ? 0 : oldToken.hashCode);

  @override
  String toString() => 'FcmTokenRefreshModel[newToken=$newToken, oldToken=$oldToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (newToken != null) {
      json[r'newToken'] = newToken;
    }
    if (oldToken != null) {
      json[r'oldToken'] = oldToken;
    }
    return json;
  }

  /// Returns a new [FcmTokenRefreshModel] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static FcmTokenRefreshModel? fromJson(Map<String, dynamic> json) => json == null
      ? null
      : FcmTokenRefreshModel(
    newToken: json[r'newToken'],
    oldToken: json[r'oldToken'],
  );

  static List<FcmTokenRefreshModel?>? listFromJson(List<dynamic>? json, {bool? emptyIsNull, bool? growable,}) =>
      json == null || json.isEmpty
          ? true == emptyIsNull ? null : <FcmTokenRefreshModel>[]
          : json.map((v) => FcmTokenRefreshModel.fromJson(v)).toList(growable: true == growable);

  static Map<String, FcmTokenRefreshModel?> mapFromJson(Map<String, dynamic>? json) {
    final map = <String, FcmTokenRefreshModel?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = FcmTokenRefreshModel.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of FcmTokenRefreshModel-objects as value to a dart map
  static Map<String, List<FcmTokenRefreshModel?>?> mapListFromJson(Map<String, dynamic>? json, {bool? emptyIsNull, bool? growable,}) {
    final map = <String, List<FcmTokenRefreshModel?>?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = FcmTokenRefreshModel.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}