import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/provider/search_provider.dart';
import 'package:submissionfundamental/utils/styles.dart';

import '../widget/content_resto.dart';

class SearchRestoPage extends StatelessWidget {
  const SearchRestoPage({Key? key}) : super(key: key);
  static const routeName = '/resto_search';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestoProvider>(
      create: (_) => SearchRestoProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const BodySearch(),
      ),
    );
  }
}

class BodySearch extends StatelessWidget {
  const BodySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchRestoProvider>(context, listen: false);
    return SafeArea(
        child: Column(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Search ',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10, right: 120),
                child: Text(
                  'Find your favorite restaurant!',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              )
            ],
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 50,
                color: Colors.blue.withOpacity(0.2)),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: 'Search',
                    filled: true),
                onSubmitted: (value) {
                  search.addQuery(value);
                },
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Consumer<SearchRestoProvider>(
        builder: (context, result, _) {
          if (result.state == SearchState.noQuery) {
            return (Center(
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: const <Widget>[
                    Icon(
                      Icons.search,
                      size: 100,
                      color: secondaryColor,
                    ),
                    Text("Find your favorite restaurant")
                  ],
                ),
              ),
            ));
          } else if (result.state == SearchState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.state == SearchState.hasData) {
            return Expanded(
              child: ListView.builder(
                itemCount: result.result.restaurants.length,
                itemBuilder: (context, index) {
                  var resto = result.result.restaurants[index];
                  return ContentResto(
                    resto: resto,
                  );
                },
              ),
            );
          } else if (result.state == SearchState.noData) {
            return const Center(
              child: Text('There is no list of restaurants you want'),
            );
          } else if (result.state == SearchState.error) {
            return const Center(
              child: Text("Oops. Your internet connection is dead :( ..."),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    ]));
  }
}
