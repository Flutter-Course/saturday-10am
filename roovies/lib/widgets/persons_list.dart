import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/providers/persons_provider.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 140,
        itemCount: Provider.of<PersonsProvider>(context).trendingPersons.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        Provider.of<PersonsProvider>(context)
                            .trendingPersons[index]
                            .posterUrl),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        Provider.of<PersonsProvider>(context)
                            .trendingPersons[index]
                            .name,
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
