class StepBonusAgency {
  StepBonusAgency({
    this.id,
    this.storeId,
    this.threshold,
    this.rewardName,
    this.rewardDescription,
    this.rewardImageUrl,
    this.rewardValue,
    this.limit,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? threshold;
  String? rewardName;
  String? rewardDescription;
  String? rewardImageUrl;
  int? rewardValue;
  int? limit;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StepBonusAgency.fromJson(Map<String, dynamic> json) => StepBonusAgency(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    threshold: json["threshold"] == null ? null : json["threshold"],
    rewardName: json["reward_name"] == null ? null : json["reward_name"],
    rewardDescription: json["reward_description"] == null ? null : json["reward_description"],
    rewardImageUrl: json["reward_image_url"] == null ? null : json["reward_image_url"],
    rewardValue: json["reward_value"] == null ? null : json["reward_value"],
    limit: json["limit"] == null ? null : json["limit"],
    active: json["active"] == null ? null : json["active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "store_id": storeId == null ? null : storeId,
    "threshold": threshold == null ? null : threshold,
    "reward_name": rewardName == null ? null : rewardName,
    "reward_description": rewardDescription == null ? null : rewardDescription,
    "reward_image_url": rewardImageUrl == null ? null : rewardImageUrl,
    "reward_value": rewardValue == null ? null : rewardValue,
    "limit": limit == null ? null : limit,
  };
}
