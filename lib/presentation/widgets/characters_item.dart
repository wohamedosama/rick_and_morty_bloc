import 'package:flutter/material.dart';
import '../../core/constants/my_colors.dart';
import '../../core/constants/string.dart';

import '../../data/model/characters_model.dart';

class CharactersItem extends StatelessWidget {
  const CharactersItem({
    super.key,
    required this.characters,
  });
  final CharactersModel characters;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            charactersDetailsScreen,
            arguments: characters,
          );
        },
        child: GridTile(
          footer: Hero(
            tag: characters.id!,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${characters.name}',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontSize: 16,
                    color: MyColors.myWhite),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.myGrey,
            child: characters.image != null
                ? FadeInImage.assetNetwork(
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/loading1.gif',
                    image: characters.image ?? 'assets/images/Art.jpeg',
                  )
                : Image.asset('assets/images/Art.jpeg'),
          ),
        ),
      ),
    );
  }
}
