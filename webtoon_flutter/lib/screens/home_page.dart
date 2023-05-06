import 'package:flutter/material.dart';
import 'package:webtoon_flutter/models/webtoon_model.dart';
import 'package:webtoon_flutter/service.dart';

import 'package:webtoon_flutter/widgets/card.dart';

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
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ToonCard(
                  toonName: snapshot.data![index].title,
                  thumbURL: snapshot.data![index].thumb,
                  toonID: snapshot.data![index].id,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
