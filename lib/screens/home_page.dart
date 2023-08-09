import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/alert/alert_popup.dart';
import 'package:flutter_base/app_localization.dart';
import 'package:flutter_base/blocs/post_bloc/post_bloc.dart';
import 'package:flutter_base/blocs/post_bloc/post_event.dart';
import 'package:flutter_base/blocs/post_bloc/post_state.dart';
import 'package:flutter_base/common_styles.dart';
import 'package:flutter_base/constants/resources_constant.dart';
import 'package:flutter_base/models/post_model.dart';
import 'package:flutter_base/screens/home/home_item_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Scroll controller
  final _scrollController = ScrollController(initialScrollOffset: 0.0);

  // Posts
  List<Post> _posts = [];

  // Loading flag
  bool _isLoading = false;

  // Sync data
  _getPosts() async {
    BlocProvider.of<PostBloc>(context).add(const RequestGetPosts());
  }
 @override
 void initState() {
   _getPosts();
    super.initState();
  }
  @override
  void dispose() {
    // Release controller
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
        builder: (context, state) => _buildUI(context),
        listener: (context, state) {
          if (state is PostLoading) {
            _isLoading = true;
          } else if (state is PostsLoaded) {
            _isLoading = false;
            _posts = state.posts;
          } else if (state is PostsLoadError) {
            _isLoading = false;
            AlertUtils.displayErrorAlert(context, state.message);
          }
        });
  }

  // Build main UI
  Widget _buildUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('home')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Header
            _buildHeader(context),
            // POSTS
            _buildPosts(context)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.sync_outlined,
            color: Colors.white,
          ),
          onPressed: _getPosts),
    );
  }

  // Build posts
  Widget _buildPosts(BuildContext context) {
    if (_isLoading) {
      return const Expanded(
          child: CupertinoActivityIndicator(
        animating: true,
      ));
    }
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () => _getPosts(),
      child: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: false,
        child: ListView.separated(
            controller: _scrollController,
            itemCount: _posts.length,
            separatorBuilder: (context, index) {
              return Divider(
                color: Theme.of(context).dividerColor,
                height: 1,
              );
            },
            itemBuilder: (context, index) {
              final item = _posts[index];
              return HomeItemComponent(post: item,);
            }),
      ),
    ));
  }

  // Create header home page
  _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: SvgPicture.asset(Resources.icAvatar),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).translate('welcome'),
              style: CommonStyles.boldTextBlack(context),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Username',
              style: CommonStyles.size16Black700(context),
            )
          ],
        ))
      ],
    );
  }
}
