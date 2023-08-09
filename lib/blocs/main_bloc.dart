import 'package:flutter/cupertino.dart';
import 'package:flutter_base/blocs/post_bloc/post_bloc.dart';
import 'package:flutter_base/blocs/system/system_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() => [
    // System
    BlocProvider<SystemBloc>(lazy: true, create: (BuildContext context) => SystemBloc()),
    // Post
    BlocProvider<PostBloc>(create: (BuildContext context) => PostBloc()),
  ];
}