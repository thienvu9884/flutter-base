import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/post_model.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class PostInitial extends PostState {
  const PostInitial();

  @override
  List<Object?> get props => [];
}

// GET POST STATES
class PostLoading extends PostState {
  const PostLoading();
}

class PostsLoaded extends PostState {
  final List<Post> posts;
  const PostsLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostsLoadError extends PostState {
  final String message;
  const PostsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}