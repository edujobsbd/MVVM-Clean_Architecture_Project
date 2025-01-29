class LoginRequest {
  final String email;
  final String password;
  final String imei;
  final String device_type;

  LoginRequest({required this.email, required this.password, required this.imei, required this.device_type});

  Map<String, dynamic> toJson() {
    return {
      'deviceType': device_type,
      'imei': imei,
      'email': email,
      'password': password,
    };
  }
}