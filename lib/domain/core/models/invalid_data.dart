class InvalidData {
  InvalidData(this.code, this.message);
  String? code;
  String? message;

  factory InvalidData.empty() => InvalidData('', '');
}
