/** TO DEVELOP
 * - carte basique (texte simple)
 * - carte langage multiple (plusieurs area avec des drapeaux) Le widget response est multiple du nombre de langues
 * - carte avec vidéo
 * - faire un gestionnaire de carte permettant de modifier html/javascript et css.
 * - En usant Webview on perds l'interaction avec Flutter. à utiliser pour quelques types de cartes
 */

import 'dart:math';

import 'package:beaver_learning/src/dao/group_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/models/enum/answer_dificulty.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/html_card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/queel_card_displayer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'card_editor.dart/mnemotechnic_dialog.dart';

class CardDisplayer extends StatefulWidget {
  CardDisplayer(
      {super.key, required this.cardToRevise, required this.goNextCard});

  final ReviseCard cardToRevise;
  final void Function(ReviseCard card, NextRevisionInfo? nextRevisionInfo)
      goNextCard;
  bool isInitialised = false;

  @override
  State<CardDisplayer> createState() => _CardDisplayerState();
}

Map<AnswerDifficulty, double> difficultyMultiplicator = {
  AnswerDifficulty.veryHard: 0.6,
  AnswerDifficulty.hard: 0.8,
  AnswerDifficulty.easy: 2.0,
  AnswerDifficulty.veryEasy: 4.0,
};

class NextRevisionInfo {
  final int durationToAdd;
  final double diffMult;

  NextRevisionInfo({required this.durationToAdd, required this.diffMult});
}

class _CardDisplayerState extends State<CardDisplayer> {
  bool isPrintAnswer = false;
  double revisorButtonHeight = 46.0;
  
  String groupOfCard = "";

  Widget getCorrectDisplayer(CardDisplayerType cardDisplayerType) {
    switch (cardDisplayerType) {
      case CardDisplayerType.queelEditor:
        return QueelCardDisplayer(
            isPrintAnswer: isPrintAnswer, cardToRevise: widget.cardToRevise);
      case CardDisplayerType.html:
        return HTMLCardDisplayer(
            isPrintAnswer: isPrintAnswer, htmlContentId: widget.cardToRevise.htmlContent);
      default:
    }
    return HTMLCardDisplayer(
        isPrintAnswer: isPrintAnswer, htmlContentId: widget.cardToRevise.htmlContent);
  }

  Future<void> init() async {
    if (!widget.isInitialised) {
      widget.isInitialised = true;
      GroupDao groupDao = GroupDao(MyDatabaseInstance.getInstance());
      var group = await groupDao.getById(widget.cardToRevise.groupId);
      setState(() {
        groupOfCard = group?.title ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    NextRevisionInfo calculateNextRevision(AnswerDifficulty answerDifficulty) {
      var diffMult =
          (1 + log(difficultyMultiplicator[answerDifficulty]!)).abs();

      var durationToAdd =
          (24 * widget.cardToRevise.nextRevisionDateMultiplicator * diffMult)
              .floor();

      return NextRevisionInfo(durationToAdd: durationToAdd, diffMult: diffMult);
    }

    return Column(
      children: [
        Text("CardId : ${widget.cardToRevise.id} HtmlContentId : ${widget.cardToRevise.htmlContent} \nGroup : ${groupOfCard}"),
        Expanded(
          child: getCorrectDisplayer(widget.cardToRevise.displayerType),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.blue[900]),
              onPressed: () {},
              child: Icon(FontAwesomeIcons.chartColumn),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.blue[900]),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MnemotechnicDialog(cardId: widget.cardToRevise.id),
                );
              },
              child:
                  Icon(FontAwesomeIcons.lightbulb, color: Colors.yellow[400]),
            ),
          ],
        ),
        if (isPrintAnswer)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPrintAnswer = false;
                        });
                        widget.goNextCard(widget.cardToRevise,
                            calculateNextRevision(AnswerDifficulty.veryHard));
                      },
                      child: Container(
                          height: revisorButtonHeight,
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Column(children: [
                            Text("Très dur"),
                            Text(
                                '${(calculateNextRevision(AnswerDifficulty.veryHard).durationToAdd / 24).toStringAsFixed(2)} jours')
                          ])))),
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPrintAnswer = false;
                        });
                        widget.goNextCard(widget.cardToRevise,
                            calculateNextRevision(AnswerDifficulty.hard));
                      },
                      child: Container(
                          height: revisorButtonHeight,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Column(children: [
                            Text("Dur"),
                            Text(
                                '${(calculateNextRevision(AnswerDifficulty.hard).durationToAdd / 24).toStringAsFixed(2)} jours')
                          ])))),
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPrintAnswer = false;
                        });
                        widget.goNextCard(widget.cardToRevise,
                            calculateNextRevision(AnswerDifficulty.easy));
                      },
                      child: Container(
                          height: revisorButtonHeight,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Column(children: [
                            Text("Facile"),
                            Text(
                                '${(calculateNextRevision(AnswerDifficulty.easy).durationToAdd / 24).toStringAsFixed(2)} jours')
                          ])))),
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPrintAnswer = false;
                        });
                        widget.goNextCard(widget.cardToRevise,
                            calculateNextRevision(AnswerDifficulty.veryEasy));
                      },
                      child: Container(
                          height: revisorButtonHeight,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: Column(children: [
                            Text("Très facile"),
                            Text(
                                '${(calculateNextRevision(AnswerDifficulty.veryEasy).durationToAdd / 24).toStringAsFixed(2)} jours')
                          ])))),
            ],
          )
        else
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      widget.goNextCard(widget.cardToRevise, null);
                    },
                    child: Container(
                        height: revisorButtonHeight,
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        child: const Text("Pass")))),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPrintAnswer = true;
                      });
                    },
                    child: Container(
                        height: revisorButtonHeight,
                        color: Colors.grey,
                        alignment: Alignment.center,
                        child: const Text("Print Answer"))))
          ])
      ],
    );
  }
}
