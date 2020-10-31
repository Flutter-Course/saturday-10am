import 'package:flutter/material.dart';
import 'package:roovies/helpers/dummy_data.dart';
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
    tabController = TabController(length: 5, vsync: this);
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
            tabs: [
              Tab(
                text: 'Action',
              ),
              Tab(
                text: 'Comedy',
              ),
              Tab(
                text: 'Romance',
              ),
              Tab(
                text: 'SCI-FI',
              ),
              Tab(
                text: 'Thriller',
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
          ],
        ),
      ),
    );
  }
}
