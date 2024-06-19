import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/cubit/cubit/characters_cubit.dart';
import '../../business_logic/cubit/cubit/characters_state.dart';
import '../../core/constants/my_colors.dart';
import '../../data/model/characters_model.dart';
import '../widgets/characters_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({
    super.key,
  });

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

late List<CharactersModel> allChracters;
late List<CharactersModel> searchedForCharacters;
bool isSeraching = false;
final searchTextController = TextEditingController();

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoadedState) {
          allChracters = (state).characters;
          return buildWidgetLoaded();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildSearchField() {
    return TextField(
      onChanged: (searchCharacters) {
        addSearchForItemsToSearchedList(searchCharacters);
      },
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a characters...',
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
    );
  }

  void addSearchForItemsToSearchedList(String searchCharacters) {
    searchedForCharacters = allChracters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchCharacters))
        .toList();
  }

  List<Widget> buildAppBarAction() {
    if (isSeraching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
          color: MyColors.myGrey,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(Icons.search),
          color: MyColors.myGrey,
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSeraching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      isSeraching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.lightShadeOfBlue,
      ),
    );
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Character',
      style: TextStyle(
        color: MyColors.myGrey,
        fontSize: 24,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildWidgetLoaded() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: searchTextController.text.isEmpty
          ? allChracters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) {
        return CharactersItem(
          characters: searchTextController.text.isEmpty
              ? allChracters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  Widget buildNoInternetConnectionWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Text(
              'Can\'t connect... check internet',
              style: TextStyle(
                color: MyColors.myGrey,
                fontSize: 24,
              ),
            ),
            Image.asset('assets/images/undraw_Signal_searching_re_yl8n.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.lightShadeOfBlue,
        title: isSeraching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarAction(),
        leading: isSeraching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetConnectionWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
/* if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetConnectionWidget();
          }*/



          /*
          Stack(
            
            fit: StackFit.expand,
            children: [
              
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected
                      ? const Color(0xFF00EE44)
                      : const Color(0xFFEE4400),
                  child: Center(
                    child: Text(connected ? 'ONLINE' : 'OFFLINE'),
                  ),
                ),
              ),
             
             
            ],
           
          );
          */