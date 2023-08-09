import 'package:flutter_base/blocs/base_bloc_custom.dart';
import 'package:flutter_base/blocs/post_bloc/post_event.dart';
import 'package:flutter_base/blocs/post_bloc/post_state.dart';
import 'package:flutter_base/services/api_call.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends BaseBlocCustom<PostEvent, PostState> {
  PostBloc() : super(const PostInitial()) {
    // GET POSTS EVENT
    on<RequestGetPosts>((event, emit) => _handleGetPosts(event, emit));
  }

  // Handle get posts
  _handleGetPosts(RequestGetPosts event, Emitter emit) async {
    emit(const PostLoading());
    try {
      final response = await ApiCall().requestGetPosts();
      emit(PostsLoaded(posts: response));
    } catch (e) {
      emit(PostsLoadError(message: handleError(e)));
    }
  }
}