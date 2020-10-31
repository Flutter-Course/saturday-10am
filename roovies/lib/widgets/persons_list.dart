import 'package:flutter/material.dart';
import 'package:roovies/helpers/dummy_data.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 140,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage(DummyData.nowPlaying[index]['poster_url']),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        DummyData.nowPlaying[index]['movie_name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
