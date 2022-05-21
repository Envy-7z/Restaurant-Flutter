import 'package:flutter/material.dart';
import 'package:submissionfundamental/data/model/local_restauran.dart';
import 'package:submissionfundamental/ui/detail_page.dart';
import 'package:submissionfundamental/utils/styles.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          try {
            final LocalRestaurant localRestaurant =
                localRestaurantFromJson(snapshot.data!);
            return ListView.builder(
              itemCount: localRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                return _content(context, localRestaurant.restaurants[index]);
              },
            );
          } catch (e) {
            return _contentError(context);
          }
        },
      ),
    );
  }

  Widget _contentError(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'There is something wrong',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, Restaurant restaurant) {
    return Material(
      color: primaryColor,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName,
              arguments: restaurant);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                Image.network(
                  restaurant.pictureId,
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x80000000),
                        Color(0x80000000),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        restaurant.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.location_pin,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: restaurant.city,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: restaurant.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
