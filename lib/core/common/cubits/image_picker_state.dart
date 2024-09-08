part of 'image_picker_cubit.dart';

enum ImagePickerStatus { initial, picking, picked }

class ImagePickerState {
  final File? image;
  final ImagePickerStatus imagePickerStatus;

  ImagePickerState({
    required this.image,
    required this.imagePickerStatus,
  });

  ImagePickerState copyWith(
      {File? image, ImagePickerStatus? imagePickerStatus}) {
    return ImagePickerState(
      image: image ?? this.image,
      imagePickerStatus: imagePickerStatus ?? this.imagePickerStatus,
    );
  }
}
