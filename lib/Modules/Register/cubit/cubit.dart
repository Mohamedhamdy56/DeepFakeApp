// import 'package:deepfake/Modules/Login/cubit/State.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//
//
// class RegisterCubit extends Cubit<LoginState>{
//   RegisterCubit():super(RegisterInitialState());
//   late List<Map> users =[];
//   static RegisterCubit getLoginCubit(context) => BlocProvider.of(context);
//   bool isPassword = true;
//   late Database database;
//   void visibility(){
//     isPassword = !isPassword;
//     emit(RegisterVisibilityState());
//   }
//   void createDatabase() {
//     openDatabase(
//       'deepfake.db',
//       version: 1,
//       onCreate:(db, version) {
//         db.execute('CREATE TABLE User (id INTEGER PRIMARY KEY, username TEXT, password TEXT, date TEXT)').then((value) {
//           print('Created Table');
//         }).catchError((error ) {
//           print('Error $error');
//         });
//       },
//       onOpen: (db) {
//         print('Opened Database');
//         getFormDatabase(db).then((value){
//           users = value;
//           print(users);
//           emit(RegisterGetDatabaseState());
//         });
//       },
//     ).then((value) {
//       database = value;
//       emit(RegisterCreateDatabaseState());
//     });
//   }
//
//   Future<List<Map>>  getFormDatabase(database) async{
//     return await database.rawQuery('SELECT * FROM User');
//   }
//
//   insertToDatabase(username,password,date ) async {
//     await database.transaction((txn) async {
//       await txn.rawInsert('INSERT INTO User (username, password, date) VALUES ("$username", "$password", "$date")').then((value) {
//         print("Inserted done");
//         emit(RegisterInsertDatabaseState());
//         getFormDatabase(database).then((value) {
//           users = value;
//           print(users);
//           emit(RegisterGetDatabaseState());
//         });
//       }).catchError((error){
//         print("error $error");
//       });
//     });
//   }
//
// }