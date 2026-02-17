import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../Shared/Components/constrant.dart';
import 'State.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitialState());

  static LoginCubit getLoginCubit(context) => BlocProvider.of(context);
  bool isPassword = true;
  bool isPasswordConfirm = true;
  late Database database;
  void visibility(){
    isPassword = !isPassword;
    emit(LoginVisibilityState());
  }
  void visibilityConfirm(){
    isPasswordConfirm = !isPasswordConfirm;
    emit(RegisterVisibilityState());
  }
  void createDatabase() {
    openDatabase(
      'deepfake.db',
      version: 1,
      onCreate:(db, version) {
        db.execute('CREATE TABLE User (id INTEGER PRIMARY KEY, username TEXT, password TEXT, date TEXT)').then((value) {
          print('Created Table');
        }).catchError((error ) {
          print('Error $error');
        });
      },
      onOpen: (db) {
        print('Opened Database');
        getFormDatabase(db).then((value){
          users = value;
          print(users);
          emit(LoginGetDatabaseState());
        });
      },
    ).then((value) {
      database = value;
      emit(LoginCreateDatabaseState());
    });
  }

  insertToDatabase(username,password,date ) async {
    await database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO User (username, password, date) VALUES ("$username", "$password", "$date")').then((value) {
        print("Inserted done");
        emit(RegisterInsertDatabaseState());
        getFormDatabase(database).then((value) {
          users = value;
          print(users);
          emit(RegisterGetDatabaseState());
        });
      }).catchError((error){
        print("error $error");
      });
    });

  }

  Future<List<Map>>  getFormDatabase(database) async{
    return await database.rawQuery('SELECT * FROM User');
  }
}