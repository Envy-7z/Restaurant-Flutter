import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/provider/resto_provider.dart';
import 'package:submissionfundamental/ui/resto_page.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RestoProvider(
              apiService: ApiService(),
            ),
        child: const RestoPage());
  }
}
