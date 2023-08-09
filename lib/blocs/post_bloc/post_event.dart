import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetPosts extends PostEvent {
  const RequestGetPosts();

  @override
  List<Object?> get props => [];
}