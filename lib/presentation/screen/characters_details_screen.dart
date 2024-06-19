// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/my_colors.dart';
import 'package:flutter_rick_and_morty/data/model/characters_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharactersModel characters;

  const CharacterDetailsScreen({
    super.key,
    required this.characters,
  });
  Widget displayRandomQoutesNumberOrEmptySpace() {
    List<String> animatedTexts = [
      'Rick Sanchez',
      'Morty Smith',
      'Summer Smith',
      'Beth Smith',
    ];
    if (animatedTexts.isNotEmpty) {
      int randomQouteIndex = Random().nextInt(animatedTexts.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 30,
            fontFamily: 'Agne',
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [TyperAnimatedText(animatedTexts[randomQouteIndex])],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 600,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          characters.name!,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        background: Hero(
          tag: characters.id!,
          child: Image.network(
            characters.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      color: MyColors.lightShadeOfBlue,
      endIndent: endIndent,
      thickness: 4,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      characterInfo('Job : ', characters.episode!.join(' / ')),
                      buildDivider(330),
                      characterInfo('Species : ', characters.species!),
                      buildDivider(290),
                      characterInfo('Status : ', characters.status!),
                      buildDivider(310),
                      characterInfo('Gender : ', characters.gender!),
                      buildDivider(300),
                      characterInfo('Origin name : ', characters.origin!.name!),
                      buildDivider(250),
                      characterInfo('Origin url : ', characters.origin!.url!),
                      buildDivider(275),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: 250,
                          child: displayRandomQoutesNumberOrEmptySpace()),
                    ],
                  ),
                ),
                const SizedBox(height: 400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
