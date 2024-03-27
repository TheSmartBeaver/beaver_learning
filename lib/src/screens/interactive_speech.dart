import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreenPage extends StatefulWidget {
  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  List<Message> messages = [
    Message(sender: 'you', text: 'Hola, ¿cómo estás?'),
    Message(sender: 'AI', text: '¡Hola! Estoy bien, ¿y tú?'),
    Message(
        sender: 'you',
        text: 'Estoy muy bien, gracias. ¿Qué me recomiendas hoy?'),
    Message(
        sender: 'AI',
        text: 'Nuestra especialidad hoy es el filete de salmón a la parrilla.'),
    Message(
        sender: 'you',
        text: '¡Suena delicioso! Me gustaría probarlo, por favor.'),
    Message(sender: 'AI', text: 'Por supuesto, ¿algo de beber?'),
    Message(sender: 'you', text: '¿Tienen vino tinto de la región?'),
    Message(sender: 'AI', text: 'Sí, tenemos un excelente Rioja.'),
    Message(sender: 'you', text: 'Perfecto, una copa de Rioja, por favor.'),
    Message(sender: 'AI', text: 'Enseguida lo traigo. ¿Algo más?'),
    // Message(sender: 'you', text: 'No, eso es todo por ahora. Gracias.'),
    // Message(sender: 'AI', text: 'De nada, disfrute de su comida.'),
  ];
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulation : Dans un café'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: messages.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < messages.length) {
            return ChatBubble(message: messages[index]);
          } else {
            return Center(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          // Add your logic here
                        },
                        child: Icon(Icons.mic),
                        backgroundColor: Colors.greenAccent,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          // Add your logic here
                        },
                        child: Icon(Icons.stop),
                        backgroundColor: Colors.redAccent,
                      ),
                      Container(
                        width: 150.0,
                        child: FloatingActionButton(
                          onPressed: () {
                            // Add your logic here
                          },
                          child: Text('Attendez...'),
                          backgroundColor: Colors.purpleAccent,
                        ),
                      )
                    ]),
              ),
            );
          }
        },
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: message.sender == 'you'
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            // Utilisation de Flexible pour permettre le saut de ligne
            child: Container(
              decoration: BoxDecoration(
                color: message.sender == 'you' ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(12.0),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.sender == 'you' ? Colors.white : Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
