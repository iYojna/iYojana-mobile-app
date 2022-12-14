// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class NewMessage extends StatefulWidget {
//   Function addMsg;
//   NewMessage(this.addMsg);
//   @override
//   State<NewMessage> createState() => _NewMessageState();
// }

// class _NewMessageState extends State<NewMessage> {
//   final _controller = new TextEditingController();

//   var _enteredMessage = '';

//   // late DialogFlowtter dialogFlowtter;

//   void _sendMessage() async {
//     if (_controller.text.isEmpty) {
//       print('empty message');
//       return;
//     }
//     String username = "Akhilesh";
//     //Provider.of<Auth>(context, listen: false).username.toString();
//     widget.addMsg(_enteredMessage, true, username);
//     FocusScope.of(context).unfocus();
//     // DialogAuthCredentials credentials =
//     //     await DialogAuthCredentials.fromFile("assets/dialogflow/service.json");
//     // DialogFlowtter instance = DialogFlowtter(
//     //   credentials: credentials,
//     // );

//     // final DialogFlowtter dialogFlowtter = DialogFlowtter(
//     //   credentials: credentials,
//     //   sessionId: DateTime.now().toString(),
//     // );
//     //if dialogflow and gcp are from same account then no work
//     // is needed to be done.
//     //simply create dialog flow agent and chose the gcp project
//     // in role give role of dialogflow service agent
//     // final QueryInput queryInput = QueryInput(
//     //   text: TextInput(
//     //     text: _enteredMessage,
//     //     languageCode: "en",
//     //   ),
//     // );
//     // DetectIntentResponse response = await dialogFlowtter.detectIntent(
//     //     queryInput: queryInput, version_rec: Versions.V2Beta1);
//     // print('responsesesesess: $response');
//     //String? textResponse = response.text;
//     // widget.addMsg(textResponse, false, 'Sahayak');
//     // print(textResponse);

//     // setState(() {
//     //   addMessage(
//     //     Message(text: DialogText(text: [_enteredMessage])),
//     //     true,
//     //   );
//     // });
//     // DetectIntentResponse response = await dialogFlowtter.detectIntent(
//     //   queryInput: QueryInput(text: TextInput(text: _enteredMessage)),
//     // );
//     // if (response.message == null) {
//     //   print('not working');
//     //   widget.addMsg('Not Working Currently, Sorry!', false, 'Sahayk');
//     // }
//   }

//   void dispose() {
//     //dialogFlowtter.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             margin: EdgeInsets.all(8),
//             padding: EdgeInsets.all(10),
//             height: 40,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15), color: Colors.black12),
//             child: TextField(
//               //Defaults to an uppercase keyboard for the first letter of each sentence.
//               textCapitalization: TextCapitalization.sentences,
//               enableSuggestions: true,
//               controller: _controller,
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.only(bottom: 10),
//                   hintText: 'Send a message..',
//                   border: InputBorder.none),
//               onChanged: (value) {
//                 setState(() {
//                   //will update entered message with every keystroke
//                   _enteredMessage = value;
//                 });
//               },
//             ),
//           ),
//         ),
//         IconButton(
//           onPressed: () {
//             _sendMessage();
//             _controller.clear();
//           },
//           icon: Icon(Icons.send),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class NewMessage extends StatefulWidget {
  Function addMsg;
  NewMessage(this.addMsg);
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  String hintText = "";

  void _sendMessage() async {
    if (_controller.text.isEmpty) {
      print('empty message');
      return;
    }
    String username = "Akhilesh";

    widget.addMsg(_controller.text, true, username);
    FocusScope.of(context).unfocus();
  }

  void dispose() {
    //dialogFlowtter.dispose();
    super.dispose();
  }

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // Function where we capture the voice
  void _onSpeechResultText(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      print(_lastWords);
      setState(() {
        _controller.text = _lastWords;
      });
      print("LOL" + hintText);
    });
  }

  void _startListeningText() async {
    var locales = await _speechToText.locales();
    // print("LOCALES: " + locales.length.toString());
    final Locale appLocale = Localizations.localeOf(context);
    print(appLocale.toString());
    if (appLocale.toString() == "es") {
      await _speechToText.listen(
          onResult: _onSpeechResultText, localeId: "gu_IN");
      setState(() {});
      return;
    }
    await _speechToText.listen(onResult: _onSpeechResultText);
    setState(() {});
  }

  void _stopListening() async {
    print("stopped");
    await _speechToText.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(10),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.black12),
            child: TextField(
              //Defaults to an uppercase keyboard for the first letter of each sentence.
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              controller: _controller,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        _speechToText.isNotListening
                            ? Icons.mic_off
                            : Icons.mic,
                        color: Colors.black,
                      ),
                      onPressed:
                          // If not yet listening for speech start, otherwise stop
                          _speechToText.isNotListening
                              ? _startListeningText
                              : _stopListening,
                      tooltip: 'Listen',
                    ),
                  ),
                  contentPadding: EdgeInsets.only(bottom: 10),
                  hintText: hintText == "" ? 'Send a message..' : hintText,
                  border: InputBorder.none),
              onChanged: (value) {
                setState(() {
                  //will update entered message with every keystroke
                  _controller.text = value;
                });
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _sendMessage();
            _controller.clear();
          },
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}
