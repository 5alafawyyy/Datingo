// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends OnboardingEvent {
  final User user;

  const StartOnboarding({
    this.user = const User(
      id: '',
      name: '',
      age: 0,
      gender: '',
      imageUrls: [],
      interests: [],
      bio: '',
      jobTitle: '',
      location: Location.initialLocation,
      swipeLeft: [],
      swipeRight: [],
      matches: [],
    ),
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends OnboardingEvent {
  final User user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final User? user;
  final XFile image;

  const UpdateUserImages({
    this.user,
    required this.image,
  });

  @override
  List<Object?> get props => [
        user,
        image,
      ];
}

class UpdateUserLocation extends OnboardingEvent {
  final Location? location;
  final GoogleMapController? controller;
  final bool isUpdateComplete;

  const UpdateUserLocation({
    this.location,
    this.controller,
    this.isUpdateComplete = false,
  });

  @override
  List<Object?> get props => [
        location,
        controller,
        isUpdateComplete,
      ];
}
