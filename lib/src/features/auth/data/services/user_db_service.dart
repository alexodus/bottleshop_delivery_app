import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/models/user_model.dart';

DatabaseService<UserModel> userDb = DatabaseService<UserModel>(
  AppDBConstants.usersCollection,
  toMap: (user) => user.toMap(),
  fromSnapshot: (id, data) => UserModel.fromMap(id, data),
);
