import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivia/features/avatar_screen/view_model/avatar_screen_manager.dart';
import 'package:trivia/utility/app_constant.dart';
import 'package:trivia/utility/color_utility.dart';
import 'package:trivia/utility/fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:trivia/utility/size_config.dart';

class EditAvatar extends ConsumerWidget {
  const EditAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarState = ref.watch(avatarScreenManagerProvider);
    final avatarNotifier = ref.read(avatarScreenManagerProvider.notifier);

    return Center(
      child: avatarState.when(
        data: (state) => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Hero(
              tag: "userAvatar",
              child: GestureDetector(
                onTap: () {
                  if (state.selectedImage != null) {
                    avatarNotifier.toggleShowTrashIcon();
                  }
                },
                child: Stack(
                  children: [
                    state.selectedImage != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(state.selectedImage!),
                            radius: calcWidth(70),
                          )
                        : FluttermojiCircleAvatar(
                            backgroundColor:
                                AppConstant.userAvatarBackground.toColor(),
                            radius: calcWidth(70),
                          ),
                    if (state.showTrashIcon)
                      Container(
                        width: calcWidth(140),
                        height: calcWidth(140),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (state.showTrashIcon)
              Positioned(
                bottom: 35,
                child: IconButton(
                  icon:
                      Icon(Icons.delete, color: Colors.white.withOpacity(0.5)),
                  onPressed: () {
                    avatarNotifier.switchImage(null);
                    avatarNotifier.toggleShowTrashIcon(false);
                  },
                ),
              ),
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      avatarNotifier.switchImage(image);
                    },
                    icon: Container(
                      width: calcWidth(45.0),
                      height: calcHeight(45.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.camera,
                        size: 30,
                        color: AppConstant.onPrimary.toColor(),
                      ),
                    ),
                  ),
                  SizedBox(width: calcWidth(55)),
                  IconButton(
                    onPressed: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      avatarNotifier.switchImage(image);
                    },
                    icon: Container(
                      width: calcWidth(45.0),
                      height: calcHeight(45.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.image,
                        size: 30,
                        color: AppConstant.onPrimary.toColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
