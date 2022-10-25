import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../buisness_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/characters_state.dart';

class CharactersDetailesScreen extends StatelessWidget {
  final Character character;
  const CharactersDetailesScreen({super.key, required this.character});
  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return diplayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget diplayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuotesIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyle(color: MyColors.mywhite, fontSize: 20, shadows: [
              Shadow(
                  blurRadius: 7, color: MyColors.myYellow, offset: Offset(0, 0))
            ]),
            child: AnimatedTextKit(repeatForever: true, animatedTexts: [
              FlickerAnimatedText(quotes[randomQuotesIndex].quote),
            ])),
      );
    } else
      return Container();
  }

  Widget showProgressIndicator() {
    return Container(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildSilverAppbar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(character.nickName,
            style: TextStyle(
              color: MyColors.mywhite,
            ),
            textAlign: TextAlign.start),
        background: Hero(
          tag: character.charId,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            style: TextStyle(
              color: MyColors.mywhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            text: title,
          ),
          TextSpan(
            style: TextStyle(
              color: MyColors.mywhite,
              fontSize: 16,
            ),
            text: value,
          )
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);

    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(slivers: [
        buildSilverAppbar(),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('job : ', character.jobs.join(' / ')),
                  buildDivider(295),
                  characterInfo(
                      'Appeared in : ', character.categoryForTwoSeries),
                  buildDivider(250),
                  characterInfo(
                      'Seasons : ', character.apperanceOfSeasons.join(' / ')),
                  buildDivider(280),
                  characterInfo('Status : ', character.statusDeadORLife),
                  buildDivider(300),
                  character.betterToCallSaulAppearance.isEmpty
                      ? Container()
                      : characterInfo('Better Call Saul Seasons : ',
                          character.betterToCallSaulAppearance.join(' / ')),
                  character.betterToCallSaulAppearance.isEmpty
                      ? Container()
                      : buildDivider(280),
                  characterInfo('Actor/Actress : ', character.actorName),
                  buildDivider(235),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CharactersCubit, CharactersState>(
                    builder: (context, state) {
                      return Center(child: checkIfQuotesAreLoaded(state));
                    },
                  )
                ]),
          ),
          SizedBox(
            height: 500,
          ),
        ]))
      ]),
    );
  }
}
