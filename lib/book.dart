import 'package:flutter/material.dart';
import 'package:blue_sky_books/page.dart';

class Book extends StatefulWidget {
  const Book({
    super.key,
    // required this.id,
    required this.title,
    required this.lang,
  });

  // final String id;
  final String title;
  final String lang;

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  final List<Map> bookList =[
    {
      "id": "momotaro",
      "ja-JA": "桃太郎",
      "en-EN": "Momotaro",
      "id-ID": "Momotaro",
      "zh-CN": "桃太郎",
      "si-SI": "මොමොටාරෝ"
    },
    {
      "id": "taketori",
      "ja-JA": "竹取物語",
      "en-EN": "bamboo cutter story",
      "id-ID": "cerita pemotong bambu",
      "zh-CN": "竹刀的故事",
      "si-SI": "උණ බම්බු කපන කතාව"
    },
    {
      "id": "cinderella",
      "ja-JA": "シンデレラ",
      "en-EN": "Cinderella",
      "id-ID": "Cinderella",
      "zh-CN": "灰姑娘",
      "si-SI": "සින්ඩරෙල්ලා"
    },
    {
      "id": "oz",
      "ja-JA": "オズの魔法使い",
      "en-EN": "wizard of oz",
      "id-ID": "penyihir ons",
      "zh-CN": "绿野仙踪",
      "si-SI": "oz හි විශාරදයා"
    },
    {
      "id": "peter_pan",
      "ja-JA": "ピーターパン",
      "en-EN": "peter pan",
      "id-ID": "peter pan",
      "zh-CN": "彼得·潘",
      "si-SI": "පීටර් පෑන්"
    },
    {
      "id": "alice",
      "ja-JA": "不思議の国のアリス",
      "en-EN": "alice in wonderland",
      "id-ID": "alice di negeri ajaib",
      "zh-CN": "爱丽丝梦游仙境",
      "si-SI": "alice in wonderland"
    }
  ];
  final String thumbnail = "thumbnail.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.darken,
          ),
          image: AssetImage('assets/common/blue_sky01.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          iconTheme: const IconThemeData(color: Colors.white70),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: GridView.extent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2,
              children: [
                for (var lang in bookList)
                  BookTitle(
                    id: lang["id"],
                    title: lang[widget.lang],
                    lang: widget.lang,
                    thumbnail: thumbnail,
                  )
              ],
            )),
      ),
    );
  }
}

// 本のタイトル
class BookTitle extends StatelessWidget {
  const BookTitle(
      {super.key,
      required this.id,
      required this.title,
      required this.lang,
      required this.thumbnail});

  final String id;
  final String title;
  final String lang;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$id/thumbnail.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(backgroundColor: Colors.white70,fontSize: 18),
          )),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ScenarioPage(id:id,title: title, lang: lang);
        }));
      },
    );
  }
}
