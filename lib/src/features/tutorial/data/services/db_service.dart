import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/features/tutorial/data/models/tutorial_model.dart';

DatabaseService<TutorialModel> tutorialDb = DatabaseService<TutorialModel>(
  AppDBConstants.appSettingsCollection,
  fromSnapshot: (id, data) => TutorialModel.fromMap(data),
  toMap: (tutorial) => tutorial.toMap(),
);
