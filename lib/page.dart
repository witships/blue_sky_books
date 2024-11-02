import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ScenarioPage extends StatefulWidget {
  const ScenarioPage(
      {super.key, required this.id, required this.title, required this.lang});

  final String id;
  final String title;
  final String lang;

  @override
  State<ScenarioPage> createState() => _PageState();
}

class _PageState extends State<ScenarioPage> {
  List scenario = [
    {
      "ja-JA": "むかしむかしあるところに、お爺さんとお婆さんが住んでいました。\n",
      "en-EN": "Once upon a time, there lived an old man and an old woman.",
      "id-ID":
          "Pada suatu ketika, hiduplah seorang lelaki tua dan seorang wanita tua."
    },
  ];
  List<Map> langs = [
    {"lang": "日本語", "value": "ja-JA"},
    {"lang": "English", "value": "en-EN"},
    {"lang": "Indonesia", "value": "id-ID"},
    {"lang": "中文", "value": "zh-CN"},
    {"lang": "සිංහල", "value": "si-SI"},
  ];
  String? selectLang = "ja-JA";

  FlutterTts flutterTts = FlutterTts();
  int voiceIndex = 0;

  // Json
  Future<void> readJson() async {
    final resJson =
        await rootBundle.loadString('assets/${widget.id}/scenario.json');
    List<dynamic> data = jsonDecode(resJson);
    setState(() {
      scenario = data;
    });
  }

  // 言語切り替え
  void changeLang(value) {
    setState(() {
      selectLang = value;
    });
  }

  // ジャンプ
  void textJump(index) {
    setState(() {
      voiceIndex = index;
    });
    voicePlay();
  }

  // voicePlay
  Future<void> voicePlay() async {
    final lang = selectLang.toString();
    await flutterTts.stop();
    await Future.delayed(const Duration(milliseconds: 550));
    await flutterTts.setLanguage(lang);
    // アプリの場合は遅めの方が良い
    // await flutterTts.setSpeechRate(0.7);
    // web用:日本語は早め
    if (selectLang == "ja-JA") {
      await flutterTts.setSpeechRate(1.2);
    } else {
      await flutterTts.setSpeechRate(1.0);
    }
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(scenario[voiceIndex][lang]);

    // 再生音声の終了時
    flutterTts.setCompletionHandler(() {
      if (voiceIndex != scenario.length - 1) {
        setState(() {
          voiceIndex++;
          voicePlay();
        });
      }
    });
  }

  Future<void> voiceStop() async {
    await flutterTts.stop();
  }

  // 初期化：onMount
  @override
  void initState() {
    super.initState();
    readJson();
    selectLang = widget.lang;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.darken,
          ),
          image: AssetImage('assets/common/blue_sky03.png'),
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
          leading: IconButton(
            onPressed: () {
              voiceStop();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            DropdownButton(
                dropdownColor: Colors.black54,
                style: const TextStyle(color: Colors.white),
                value: selectLang,
                items: const [
                  DropdownMenuItem(
                    value: "ja-JA",
                    child: Text("日本語"),
                  ),
                  DropdownMenuItem(
                    value: "en-EN",
                    child: Text("English"),
                  ),
                  DropdownMenuItem(
                    value: "id-ID",
                    child: Text("Indonesia"),
                  ),
                  DropdownMenuItem(
                    value: "zh-CN",
                    child: Text("中文"),
                  ),
                  // DropdownMenuItem(
                  //   value: "si-SI",
                  //   child: Text("සිංහල"),
                  // )
                ],
                onChanged: (String? value) {
                  setState(() {
                    changeLang(value);
                    voiceStop();
                    // voicePlay();
                  });
                })
          ],
        ),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white70,
            ),
            child: Column(
              children: [
                Image.asset("assets/${widget.id}/thumbnail.png"),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10, bottom: 50),
                      itemCount: scenario.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: InkWell(
                            child: index == voiceIndex
                                ? Text(
                                    '${scenario[index][selectLang]}',
                                    style: const TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text('${scenario[index][selectLang]}'),
                            onTap: () {
                              textJump(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          children: [
            const Spacer(),
            FloatingActionButton(
              onPressed: () {
                voiceStop();
              },
              child: const Icon(Icons.stop_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
