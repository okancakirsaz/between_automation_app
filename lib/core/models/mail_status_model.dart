class MailStatusModel {
  String mailAdress;
  bool isMailSended;
  String? reason;

  MailStatusModel({
    required this.mailAdress,
    required this.isMailSended,
    this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'mailAdress': mailAdress,
      'isMailSended': isMailSended,
      'reason': reason,
    };
  }

  factory MailStatusModel.fromJson(Map<String, dynamic> json) {
    return MailStatusModel(
      mailAdress: json['mailAdress'] as String,
      isMailSended: json['isMailSended'] as bool,
      reason: json['reason'] as String?,
    );
  }

  @override
  String toString() =>
      "MailStatusModel(mailAdress: $mailAdress,isMailSended: $isMailSended,reason: $reason)";

  @override
  int get hashCode => Object.hash(mailAdress, isMailSended, reason);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailStatusModel &&
          runtimeType == other.runtimeType &&
          mailAdress == other.mailAdress &&
          isMailSended == other.isMailSended &&
          reason == other.reason;
}
