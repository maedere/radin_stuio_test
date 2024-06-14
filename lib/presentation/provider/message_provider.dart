import 'package:flutter/material.dart';
import 'package:open_ai_chat_bot/domain/message_model.dart';

class MessageProvider extends ChangeNotifier {
  Message? _message;

  void setMessage(Message message) {
    print("ffffffffffffff");
    _message = message;
    notifyListeners(); // Notify listeners of the change
  }
  void cleanMessage(){
    _message=null;
    notifyListeners();
  }

  Message? get message => _message;
}