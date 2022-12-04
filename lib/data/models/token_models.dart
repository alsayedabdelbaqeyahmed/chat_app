import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/domail/entities/token_entites.dart';

class TokenModels extends TokenEntitity {
  TokenModels({required super.token});
  Map<String, dynamic> toJson() {
    return {
      AppConstansts.token: super.token,
    };
  }

  factory TokenModels.fromJson(Map<String, dynamic> map) {
    return TokenModels(token: AppConstansts.token);
  }
}
