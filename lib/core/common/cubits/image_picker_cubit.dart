import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit()
      : super(ImagePickerState(
            image: null, imagePickerStatus: ImagePickerStatus.initial));

  void pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      emit(state.copyWith(imagePickerStatus: ImagePickerStatus.picking));
      XFile? pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        emit(state.copyWith(
            image: File(pickedFile.path),
            imagePickerStatus: ImagePickerStatus.picked));
      }
    } catch (e) {
      emit(state.copyWith());
    }
  }
}
