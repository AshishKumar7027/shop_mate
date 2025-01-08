import 'package:flutter/cupertino.dart';

class ManageKeyBoard{

  static void hideKeyBoard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }
  }
}