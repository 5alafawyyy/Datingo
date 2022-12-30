import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets.dart';
import '../models/models.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'user_image',
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
          left: 16.w,
          right: 16.w,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.35,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(user.imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
                left: 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name}, ${user.age}',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      user.jobTitle,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 0.72.sw,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    UserImage.small(url: user.imageUrls[0]),
                                    UserImage.small(url: user.imageUrls[0]),
                                    UserImage.small(url: user.imageUrls[0]),
                                    UserImage.small(url: user.imageUrls[0]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 35.r,
                          height: 35.r,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.info_outline,
                            size: 25.r,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
