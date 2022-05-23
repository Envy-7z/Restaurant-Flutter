import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';
import 'package:submissionfundamental/provider/database_provider.dart';
import 'package:submissionfundamental/ui/restodetail_page.dart';
import 'package:submissionfundamental/utils/result_state.dart';
import 'package:submissionfundamental/utils/styles.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const routeName = '/resto_favorite';

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<DatabaseProvider>().getFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavoriteBody(),
    );
  }
}

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30),
              child: Text(
                'Favorite Restaurant ',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 30),
              child: Text(
                'List of your favorite restaurants',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Consumer<DatabaseProvider>(builder: (context, favorite, _) {
          if (favorite.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (favorite.state == ResultState.hasData) {
            return Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: favorite.favorites.length,
              itemBuilder: (context, index) {
                return FavoriteData(resto: favorite.favorites[index]);
              },
            ));
          } else if (favorite.state == ResultState.noData) {
            return const Center(
              child: Text('No favorite Restaurant'),
            );
          } else if (favorite.state == ResultState.error) {
            return const Center(
                child: Text('Oops. Your internet connection is dead :( ...'));
          } else {
            return Container();
          }
        })
      ],
    ));
  }
}

class FavoriteData extends StatelessWidget {
  final Restaurant resto;

  const FavoriteData({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(resto.id),
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                      builder: (_) => DetailRestoPage(resto: resto)),
                )
                    .then((_) {
                  context.read<DatabaseProvider>().getFavorites();
                });
              },
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          margin: const EdgeInsets.only(left: 40, bottom: 20),
                          child: Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                    tag: resto,
                                    child: Image.network(
                                      "https://restaurant-api.dicoding.dev/images/medium/" +
                                          resto.pictureId,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ))),
                          )),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.white70),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resto.name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    resto.city,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(resto.rating.toString())
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            );
          },
        );
      },
    );
  }
}
