import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier{
   int _index = 0;
   bool _loginTF = false;
   final String _loginID = '';
   final String _loginPW = '';
   final String _writeRole = '';
   final String _userRole ='';
   String _menuStr ='';
   String _comment ='';

   int get index => _index;
   List<List<String>> get menuList => _menuList;
   bool get loginTF => _loginTF;
   String get loginId => _loginID;
   String get loginPw => _loginPW;
   String get writeRole => _writeRole;
   String get userRole => _userRole;
   String get comment => _comment;



   String changeText(){
      _menuStr =  _menuList[_index][1].split(',').join('\n');

     return _menuStr;
   }
   String changeComment(){

     return _comment;
   }


   final List<List<String>> _menuList = [
   ['start','1.Login,2.Logout,3.Service,4.Status,5.Regist,6.Exit','NumberQuestion'],
   ['start,1.Login','Check login...','chkBool'],
   ['start,1.Login,T','Activated.','InitMenu'],
   ['start,1.Login,F','Not Activated. \nLogin?[Y/N]','YNQuestion'],
   ['start,1.Login,F,Y','Login..., input ID. ','StringQuestion'],
   ['start,1.Login,F,Y,writingID','Login input Password.','StringQuestion'],
   ['start,1.Login,F,Y,writingID,writingPassword','Login input Password.','chkBool'],
   ['start,1.Login,F,Y,writingID,writingPassword,chkBool','Check login...','chkBool'],
   ['start,1.Login,F,N','No login. ','InitMenu'],
   ['start,4.Status','Status...','PrintStatus'],
   ['start,5.Regist','Regist...ID:','StringQuestion'],
   ['start,5.Regist,writingID','Regist...PW:','StringQuestion'],
   ['start,5.Regist,writingID,writingPassword','Regist...Role: admin, user','StringQuestion'],
   ['start,5.Regist,writingID,writingPassword,writingRole','Regist...','chkBool'],
   ];

  void inputValue(String value) {
    print('입력된 텍스트: $value');



    String menuType = _menuList[_index][2];
    if(menuType == 'NumberQuestion') {
      List<String> menuSplit = _menuList[_index][1].split(',');
      int chooseNum = 0;
      try {
        chooseNum = int.parse(value);
      }catch(e){
        _index =0;
        print('숫자가 아닙니다.');
        notifyListeners();
      }
      print('chooseNum: $chooseNum');
      print('menuSplit: ${menuSplit[chooseNum-1]}');
      print('menuResult: ${_menuList[_index][0]},${menuSplit[chooseNum-1]}');
      _index = _menuList.indexWhere((element) => element[0] == '${_menuList[_index][0]},${menuSplit[chooseNum-1]}');
    }
    else if(menuType == 'chkBool'){
      String menuStr = _menuList[_index][0];
      if(menuStr == 'start,1.Login'){
        if(_loginTF){
          menuStr = 'start,1.Login,T';
        }else{
          menuStr = 'start,1.Login,F';
        }
      }
      _index = _menuList.indexWhere((element) => element[0] == menuStr);

    }
    else if(menuType== 'YNQuestion'){
      String menuStr = _menuList[_index][0];
      if(value=="Y" || value=="y"){
       menuStr = 'start,1.Login,F,Y';
      }else if(value=="N" || value=="n"){
        menuStr = 'start,1.Login,F,N';
      }
      _index = _menuList.indexWhere((element) => element[0] == menuStr);
    }
    else if(menuType == 'InitMenu'){
      _index = _menuList.indexWhere((element) => element[0] == 'start');
    }
    else if(menuType == 'YNQuestion'){
      String menuStr = 'start,1.Login,F';

    }
    notifyListeners();


  }

}



class MyHomePage extends StatelessWidget{

  TextEditingController textFieldController = TextEditingController();

  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return  Scaffold(
      body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex:2,
                    child: Container(
                      color: Colors.black,
                      margin: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(appState.changeText(), style: TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextField(
                              onSubmitted: (String value) {
                                print('입력된 텍스트: $value');

                                appState.inputValue(value);

                              },
                              controller: textFieldController,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          child: ElevatedButton(
                            onPressed: () {
                              appState.inputValue(textFieldController.text);
                            },
                            child: Text('Next'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );



  }
  
}

 