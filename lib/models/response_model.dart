class ResponseModel {
  final bool _isSuccess;
  final String _message;
  final int? statusCode;

  ResponseModel(this._isSuccess, this._message, {this.statusCode});
  String get message => _message;
  bool get isSuccess => _isSuccess;
  
}
