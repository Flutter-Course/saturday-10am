import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/providers/genres_provider.dart';
import 'package:roovies/widgets/movies_list.dart';

class GenresList extends StatefulWidget {
  @override
  _GenresListState createState() => _GenresListState();
}

class _GenresListState extends State<GenresList> with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length:
            Provider.of<GenresProvider>(context, listen: false).genres.length,
        vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: Provider.of<GenresProvider>(context).genres.map((genre) {
              return Tab(
                text: genre.name,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: Provider.of<GenresProvider>(context).genres.map((genre) {
            return MoviesList.byGenre(genre.id);
          }).toList(),
        ),
      ),
    );
  }
}
