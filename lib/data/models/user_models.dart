import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/domail/entities/user_entites.dart';

class UserModels extends UserEntitity {
  UserModels({
    required super.userCountry,
    required super.userDialCode,
    required super.userId,
    required super.userImage,
    required super.userName,
    required super.userPhone,
  });
  Map<String, dynamic> toJson() {
    return {
      AppConstansts.conuserCountry: super.userCountry,
      AppConstansts.conuserDialCode: super.userDialCode,
      AppConstansts.conUserId: super.userId,
      AppConstansts.conUserImageUrl: super.userImage,
      AppConstansts.conuserName: super.userName,
      AppConstansts.conuserPhone: super.userPhone
    };
  }

  factory UserModels.fromJson(Map<String, dynamic> map) {
    return UserModels(
      userCountry: map[AppConstansts.conuserCountry],
      userDialCode: map[AppConstansts.conuserDialCode],
      userId: map[AppConstansts.conUserId],
      userImage: map[AppConstansts.conUserImageUrl],
      userName: map[AppConstansts.conuserName],
      userPhone: map[AppConstansts.conuserPhone],
    );
  }
}
