

class VerifyBody {
  String phoneNumber;
  String passcode;

  VerifyBody({
    required this.phoneNumber,
    required this.passcode,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber':phoneNumber,
      'passcode':passcode,
    };
  }
}
