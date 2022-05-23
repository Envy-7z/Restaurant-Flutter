import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/data/db/database_helper.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';
import 'package:submissionfundamental/provider/database_provider.dart';
import 'package:submissionfundamental/provider/detail_provider.dart';
import 'package:submissionfundamental/ui/main_page.dart';
import 'package:submissionfundamental/utils/result_state.dart';
import 'package:submissionfundamental/utils/styles.dart';
import 'package:submissionfundamental/widget/content_drink.dart';
import 'package:submissionfundamental/widget/content_food.dart';
import 'package:submissionfundamental/widget/nav_bar.dart';

class DetailRestoPage extends StatelessWidget {
  static const routeName = 'detail/restaurant';
  final Restaurant resto;

  const DetailRestoPage({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, NavBar.routeName);
          if (kDebugMode) {
            print("After clicking the Android Back Button");
          }
          return false;
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<RestoDetailProvider>(
              create: (_) =>
                  RestoDetailProvider(apiService: ApiService(), id: resto.id),
            ),
            ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
            ),
          ],
          child: Scaffold(
            body: _builder(context),
          ),
        ));
  }

  Widget _builder(context) {
    return Consumer<RestoDetailProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        final value = state.detailRestaurant;
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://restaurant-api.dicoding.dev/images/medium/' +
                                    value.restaurant.pictureId),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, NavBar.routeName);
                                },
                              ),
                            ]),
                        const SizedBox(
                          height: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Consumer<DatabaseProvider>(
                              builder: (context, favorite, child) {
                                return FutureBuilder<bool>(
                                  future: favorite.isFavorited(resto.id),
                                  builder: (context, snapshot) {
                                    var isFavorited = snapshot.data ?? false;
                                    return Container(
                                        height: 70,
                                        width: 70,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: isFavorited
                                            ? IconButton(
                                                icon:
                                                    const Icon(Icons.favorite),
                                                color: Colors.redAccent,
                                                onPressed: () => favorite
                                                    .removeFavorite(resto.id),
                                              )
                                            : IconButton(
                                                icon: const Icon(
                                                    Icons.favorite_border),
                                                color: Colors.redAccent,
                                                onPressed: () =>
                                                    favorite.addFavorite(resto),
                                              )
                                        // child: Center(child: LoveButton()),
                                        );
                                  },
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.restaurant.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: secondaryColor,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(value.restaurant.city)
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(value.restaurant.description),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Foods',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        ContentFood(foods: value.restaurant.menus.foods),
                        const SizedBox(height: 30),
                        Text(
                          'Drinks',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        ContentDrink(drinks: value.restaurant.menus.drinks),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return const Center(
          child: Text(''),
        );
      }
    });
  }
}
