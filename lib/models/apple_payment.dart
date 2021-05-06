class ApplePayment {
  /// Returns a new [ApplePayment] instance.
  ApplePayment({
    this.transactionReceipt,
    this.entityId,
    this.planId,
  });

  String? transactionReceipt;

  int? entityId;

  int? planId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApplePayment &&
     other.transactionReceipt == transactionReceipt &&
     other.entityId == entityId &&
     other.planId == planId;

  @override
  int get hashCode =>
    (transactionReceipt == null ? 0 : transactionReceipt.hashCode) +
    (entityId == null ? 0 : entityId.hashCode) +
    (planId == null ? 0 : planId.hashCode);

  @override
  String toString() => 'ApplePayment[transactionReceipt=$transactionReceipt, entityId=$entityId, planId=$planId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (transactionReceipt != null) {
      json[r'transactionReceipt'] = transactionReceipt;
    }
    if (entityId != null) {
      json[r'entityId'] = entityId;
    }
    if (planId != null) {
      json[r'planId'] = planId;
    }
    return json;
  }

  /// Returns a new [ApplePayment] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ApplePayment? fromJson(Map<String, dynamic>? json) => json == null
    ? null
    : ApplePayment(
        transactionReceipt: json[r'transactionReceipt'],
        entityId: json[r'entityId'],
        planId: json[r'planId'],
    );

  static List<ApplePayment?>? listFromJson(List<dynamic>? json, {bool? emptyIsNull, bool? growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <ApplePayment>[]
      : json.map((v) => ApplePayment.fromJson(v)).toList(growable: true == growable);

  static Map<String, ApplePayment?> mapFromJson(Map<String, dynamic>? json) {
    final map = <String, ApplePayment?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = ApplePayment.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of ApplePayment-objects as value to a dart map
  static Map<String, List<ApplePayment?>?> mapListFromJson(Map<String, dynamic>? json, {bool? emptyIsNull, bool? growable,}) {
    final map = <String, List<ApplePayment?>?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = ApplePayment.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}

