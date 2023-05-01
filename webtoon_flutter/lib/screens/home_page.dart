import 'package:flutter/material.dart';
import 'package:webtoon_flutter/models/webtoon_model.dart';
import 'package:webtoon_flutter/service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodayToons();

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          'Today\'s toons.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(),
    );
  }
}
