class InputUserModel {
  String userId;
  String password;
  InputUserModel({required this.userId, required this.password});
  factory InputUserModel.empty() {
    return InputUserModel(userId: "", password: "");
  }
}
