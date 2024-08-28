class InvalidData {
  InvalidData(
    this.code,
    this.messageEn,
    this.messageEs,
  );
  String? code;
  String? messageEn;
  String? messageEs;

  factory InvalidData.empty() => InvalidData('', '', '');
}
