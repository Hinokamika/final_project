import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserData {
  final String name;
  final String imgUrl;
  final String gender;
  final String ageGroup;
  final String primaryHealthGoal;
  final String fitnessGoal;
  final String additionalNotes;
  final String fitnessLevel;
  final String exerciseStatus;
  final String exerciseFrequency;

  UserData({
    required this.name,
    this.imgUrl = '',
    required this.gender,
    required this.ageGroup,
    required this.primaryHealthGoal,
    required this.fitnessGoal,
    this.additionalNotes = '',
    this.fitnessLevel = '',
    required this.exerciseStatus,
    this.exerciseFrequency = '',
  });

  UserData copyWith({
    String? name,
    String? imgUrl,
    String? gender,
    String? ageGroup,
    String? primaryHealthGoal,
    String? fitnessGoal,
    String? additionalNotes,
    String? fitnessLevel,
    String? exerciseStatus,
    String? exerciseFrequency,
  }) {
    return UserData(
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      primaryHealthGoal: primaryHealthGoal ?? this.primaryHealthGoal,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      exerciseStatus: exerciseStatus ?? this.exerciseStatus,
      exerciseFrequency: exerciseFrequency ?? this.exerciseFrequency,
    );
  }
}

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier()
    : super(
        UserData(
          name: '',
          imgUrl: '',
          gender: '',
          ageGroup: '',
          primaryHealthGoal: '',
          fitnessGoal: '',
          additionalNotes: '',
          fitnessLevel: '',
          exerciseStatus: '',
          exerciseFrequency: '',
        ),
      );

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void updateImageUrl(String newImgUrl) {
    state = state.copyWith(imgUrl: newImgUrl);
  }

  void updateGender(String newGender) {
    state = state.copyWith(gender: newGender);
  }

  void updateAgeGroup(String newAgeGroup) {
    state = state.copyWith(ageGroup: newAgeGroup);
  }

  void updatePrimaryHealthGoal(String newGoal) {
    state = state.copyWith(primaryHealthGoal: newGoal);
  }

  void updateFitnessGoal(String newFitnessGoal) {
    state = state.copyWith(fitnessGoal: newFitnessGoal);
  }

  void updateAdditionalNotes(String newNotes) {
    state = state.copyWith(additionalNotes: newNotes);
  }

  void updateFitnessLevel(String newFitnessLevel) {
    state = state.copyWith(fitnessLevel: newFitnessLevel);
  }

  void updateExerciseStatus(String newExerciseStatus) {
    state = state.copyWith(exerciseStatus: newExerciseStatus);
  }

  void updateExerciseFrequency(String newFrequency) {
    state = state.copyWith(exerciseFrequency: newFrequency);
  }
  
}

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserData>(
  (ref) => UserDataNotifier(),
);

final isDataCompleteProvider = Provider<bool>((ref) {
  final userData = ref.watch(userDataProvider);
  return userData.name.isNotEmpty &&
         userData.gender.isNotEmpty &&
         userData.ageGroup.isNotEmpty &&
         userData.primaryHealthGoal.isNotEmpty &&
         userData.fitnessGoal.isNotEmpty &&
         userData.exerciseStatus.isNotEmpty;
});
