import 'dart:convert';

import 'package:http/http.dart' as http;

class Giphy {
  String name;
  String url;

  Giphy({
    required this.name,
    required this.url,
  });
}

Future<List<Giphy>> getGifts() async {
  final response = await http.get(
    Uri.parse(
        'https://api.giphy.com/v1/gifs/trending?api_key=tUfg38rQQqHmeM8Ga8AxX8JZNjjlQk2M&limit=10&rating=g'),
  );

  List<Giphy> gifs = [];
  if (response.statusCode == 200) {
    String stringResponse =
        const Utf8Decoder().convert(response.body.codeUnits);
    final jsonData = jsonDecode(stringResponse);

    for (var item in jsonData["data"]) {
      gifs.add(
          Giphy(name: item["title"], url: item["images"]["downsized"]["url"]));
    }
    return gifs;
  } else {
    throw Exception('ERROR! Failed to load post');
  }
}
