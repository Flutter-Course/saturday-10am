import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:roovies/helpers/dummy_data.dart';

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45 - 48,
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
                  flex: 7,
                  child: Image.network(
                    DummyData.nowPlaying[index]['poster_url'],
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
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
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '8.0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      RatingBar(
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        initialRating: 4,
                        itemPadding: EdgeInsets.all(2),
                        itemSize: 10,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: null,
                      ),
                    ],
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
