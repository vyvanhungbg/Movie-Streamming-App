import 'package:cinema/injection.dart';
import 'package:cinema/src/persentation/favorite/bloc/favorite_movie_bloc.dart';
import 'package:cinema/src/persentation/favorite/widgets/body_favorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return const BodyFavoriteWidget();
  }
}
