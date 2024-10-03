part of 'edit_profile_cubit.dart';

class EditProfileState {}

class EditProfileInit extends EditProfileState {}

class EditProfileFetch extends EditProfileState {
  final UserModel user;
  final Uint8List? bytes;
  final List<String> regionList;
  EditProfileFetch({required this.user, required this.bytes, required this.regionList});
}
