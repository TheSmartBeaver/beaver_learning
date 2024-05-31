import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:flutter/material.dart';

class MnemotechnicDialog extends StatefulWidget {
  final int cardId;

  const MnemotechnicDialog({super.key, required this.cardId});

  @override
  _MnemotechnicDialogState createState() => _MnemotechnicDialogState();
}

class _MnemotechnicDialogState extends State<MnemotechnicDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> init() async {
      // Récupérer l'aide mnémotechnique enregistrée
      var database = MyDatabaseInstance.getInstance();
      var mnemotechnic = (await (database.select(database.reviseCards)
            ..where((tbl) => tbl.id.equals(widget.cardId)))
          .getSingle()).mnemotechnicHint ?? '';
      _textEditingController.text = mnemotechnic;
    }

    return AlertDialog(
      title: Text('Aide mnémotechnique'),
      content: FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return Container(
        width: double.maxFinite,
        child: TextField(
          controller: _textEditingController,
          maxLines: null, // Allow unlimited lines
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Saisissez votre aide mnémotechnique',
          ),
        ),
      );
        }
      }),
      actions: [
        TextButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Enregistrer'),
          onPressed: () async {
            String mnemotechnic = _textEditingController.text;
            // Faites quelque chose avec l'aide mnémotechnique enregistrée
            var database = MyDatabaseInstance.getInstance();
            final cardDao = CardDao(database);
            try{
              await cardDao.updateMnemotechnicHint(widget.cardId, mnemotechnic);
            } catch (e) {
              print(e);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}