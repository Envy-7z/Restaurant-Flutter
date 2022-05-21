import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submissionfundamental/provider/resto_provider.dart';
import 'package:submissionfundamental/ui/restosearch_page.dart';

import '../widget/content_resto.dart';

class RestoPage extends StatelessWidget {
  const RestoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 16,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(
              Icons.location_on,
              size: 24,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
          // titleSpacing: 0,
          title: Text(
            "Submission 2 Flutter",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5, top: 5),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/icon.png'),
                backgroundColor: Colors.blue,
                radius: 30,
              ),
            ),
          ],
        ),
        body: Consumer<RestoProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              return SafeArea(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 15, left: 25, right: 25),
                          child: Text(
                            'What is your ',
                            style: TextStyle(
                                fontSize: 32,
                                letterSpacing: 2,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 25, bottom: 10, right: 25),
                          child: Text(
                            'Favorite Restaurant? ',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 28,
                                letterSpacing: 2,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('Find the place you are going',   style: TextStyle(
                            fontWeight: FontWeight.w300, // light
                            fontStyle: FontStyle.italic, // italic),
                      )),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                SearchRestoPage.routeName,
                              );
                            },
                            icon: const Icon(Icons.search, size: 24),
                            tooltip: 'Find the place you are going',
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 0),
                          child: Text(
                            'Restaurant ',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, right: 60),
                          child: Text(
                            'Recommended restaurant for you!',
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
                      height: 10,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: state.result.restaurants.length,
                            itemBuilder: (context, index) {
                              var resto = state.result.restaurants[index];
                              return ContentResto(
                                resto: resto,
                              );
                            })),
                  ],
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.Error) {
              return Center(
                  child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 200),
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/no-wifi.png'))),
                  ),
                  Text(
                    state.message,
                  )
                ],
              ));
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        )
        // padding: EdgeInsets.only(top: 15, left: 30),
        );
  }
}
