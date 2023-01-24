

class SignUpBody {
  String name;
  String phone;
  String email;
  String password;

  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email':email,
      'f_name': name,
      'password':password,
      'phone':phone,
    };
  }
}
