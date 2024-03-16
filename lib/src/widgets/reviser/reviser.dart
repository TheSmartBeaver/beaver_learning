import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/answer_dificulty.dart';
import 'package:beaver_learning/src/providers/revise_provider.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer.dart';
import 'package:beaver_learning/src/widgets/card/card_displayer/html_card_displayer.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevisorDisplayer extends ConsumerStatefulWidget {
  RevisorDisplayer({super.key, this.initialcards});

  static const routeName = '/revisorDisplayerScreen';
  List<ReviseCard>? initialcards;
  bool isInitialized = false;

  @override
  ConsumerState<RevisorDisplayer> createState() => _RevisorDisplayerState();
}

Map<AnswerDifficulty, double> difficultyMultiplicator = {
      AnswerDifficulty.veryHard: 0.25,
      AnswerDifficulty.hard: 0.5,
      AnswerDifficulty.easy: 2.0,
      AnswerDifficulty.veryEasy: 4.0,
    };

class _RevisorDisplayerState extends ConsumerState<RevisorDisplayer> {
  int counter = 0;
  ReviseCard? cardToRevise;
  List<ReviseCard>? initialcards;

  _RevisorDisplayerState();

  getReviseCards(WidgetRef ref) async {
    var cards = await ref.read(reviseProvider.notifier).getAllCardsToRevise();
    setState(() {
      initialcards = cards;
      cardToRevise = initialcards?[counter];
    });
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isInitialized) {
      initialcards = widget.initialcards;
      if (initialcards != null && initialcards!.isNotEmpty) {
        cardToRevise = initialcards![counter];
      } else {
        getReviseCards(ref);
      }
    }
    widget.isInitialized = true;
  }

  void goNextCard(ReviseCard card, AnswerDifficulty answerDifficulty) async {
    
    final cardDao = CardDao(MyDatabaseInstance.getInstance());
    var today = DateTime.now();
    var fakeToday = DateTime(today.year, today.month, today.day, 1);

    var durationToAdd = (24 * card.nextRevisionDateMultiplicator * difficultyMultiplicator[answerDifficulty]!).floor();

    var diffMult = difficultyMultiplicator[answerDifficulty]!;
    var newMultiplicator = diffMult * card.nextRevisionDateMultiplicator;
    var newNextRevisionDate = fakeToday.add(Duration(hours: durationToAdd));

    await cardDao.updateNextRevision(card.id, newMultiplicator, newNextRevisionDate);
    print('nouvelle date de révision : ${newNextRevisionDate.toString()} Nouveau multiplicateur : ${newMultiplicator.toString()}');

    if (counter < initialcards!.length - 1) {
      setState(() {
        counter++;
        cardToRevise = initialcards?[counter];
      });
    } else {
      setState(() {
        counter++;
        cardToRevise = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int cardsLeft = (initialcards?.length ?? 0) - counter;

    return Scaffold(
        appBar: AppBar(title: const Text("Revisor")),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Row(children: [
                  Text(initialcards?.length.toString() ?? "0",
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  const Text(" "),
                  const Text("cards to repeat")
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: Row(children: [
                  Text(cardsLeft.toString(),
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  const Text(" "),
                  const Text("cards left")
                ]),
              )
            ]),
            Expanded(
                child: cardToRevise != null
                    ? CardDisplayer(
                        cardToRevise: cardToRevise!, goNextCard: goNextCard)
                    : const Center(child: Text("No more cards to revise")))
          ],
        ),
        drawer: const AppDrawer());
  }
}
