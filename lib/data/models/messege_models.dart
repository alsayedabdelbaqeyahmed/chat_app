import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/domail/entities/messege_entites.dart';

class MessegeModels extends MessegeEntitity {
  MessegeModels({
    required super.createdAt,
    required super.friendName,
    required super.friendphone,
    required super.messegetext,
    required super.userId,
    required super.userName,
    required super.userPhone,
  });
  Map<String, dynamic> toJson() {
    return {
      AppConstansts.conChatCreatedAt: super.createdAt,
      AppConstansts.conFriendUserName: super.friendName,
      AppConstansts.conFriendPhone: super.friendphone,
      AppConstansts.conText: super.messegetext,
      AppConstansts.conUserId: super.userId,
      AppConstansts.conuserName: super.userName,
      AppConstansts.conuserPhone: super.userPhone,
    };
  }

  factory MessegeModels.fromJson(Map<String, dynamic> map) {
    return MessegeModels(
      createdAt: map[AppConstansts.conChatCreatedAt],
      friendName: map[AppConstansts.conFriendUserName],
      friendphone: map[AppConstansts.conFriendPhone],
      messegetext: map[AppConstansts.conText],
      userId: map[AppConstansts.conUserId],
      userName: map[AppConstansts.conuserName],
      userPhone: map[AppConstansts.conuserPhone],
    );
  }
}
