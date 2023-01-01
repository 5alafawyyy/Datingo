import 'package:datingo/blocs/blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageContainer extends StatelessWidget {
  final String? imageUrl;
  const CustomImageContainer({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.0.h,
        right: 10.0.w,
      ),
      child: Container(
        height: 0.18.sh,
        width: 0.25.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        child: imageUrl == null
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    // Check if the image not selected
                    if (image == null) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No image was selected.'),
                        ),
                      );
                    }

                    if (image != null) {
                      if (kDebugMode) {
                        print('Uploading.......');
                        print(image.name);
                      }
                      context.read<OnboardingBloc>()
                        .add(
                          UpdateUserImages(image: image),
                        );
                    }
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
