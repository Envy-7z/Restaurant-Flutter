import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/provider/resto_provider.dart';
import 'package:submissionfundamental/utils/styles.dart';

import '../widget/content_drink.dart';
import '../widget/content_food.dart';
import 'main_page.dart';

class DetailRestoPage extends StatefulWidget {
  static const routeName = 'detail/restaurant';
  final String id;

  const DetailRestoPage({required this.id});

  @override
  State<DetailRestoPage> createState() => _DetailRestoState();
}

class _DetailRestoState extends State<DetailRestoPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoProvider>(
        create: (_) => RestoProvider(
            apiService: ApiService(), type: 'detail', id: widget.id),
        child: Scaffold(
            body: Consumer<RestoProvider>(builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            final resto = state.result;
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
                                        resto.restaurant.pictureId),
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
                                          context, MainPage.routeName);
                                    },
                                  ),
                                ]),
                            const SizedBox(
                              height: 200,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resto.restaurant.name,
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
                                Text(resto.restaurant.city)
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
                            Text(resto.restaurant.description),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Foods',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            ContentFood(foods: resto.restaurant.menus.foods),
                            const SizedBox(height: 30),
                            Text(
                              'Drinks',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            ContentDrink(drinks: resto.restaurant.menus.drinks),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        })));
  }
}
