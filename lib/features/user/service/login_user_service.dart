// login_user_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../model/user_model.dart';

class UserService with ChangeNotifier {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _userModel; // Modelo do usuário autenticado
  String? _institutionId; // ID da instituição

  UserModel? get userModel => _userModel;
  String? get institutionId => _institutionId;
  String get userType => _userModel?.userType ?? 'guest';

  // Verifica se o usuário está logado
  bool get isLoggedIn => _userModel != null;

  // Getter para verificar se o usuário é um guest (convidado)
  bool get isGuest => _userModel == null || _userModel!.userType == 'guest';

  // Verifica se o usuário é admin
  bool get isAdmin => _userModel?.userType == 'admin';

  // Verifica se o usuário é um representante
  bool get isRepresentative => _userModel?.userType == 'representative' && _userModel!.isActive;

  // Função para registrar um novo usuário
  Future<void> registerWithEmail(
      String nome, String email, String password, String userType, String institutionId,
      {String? turmaId}) async {
    try {
      // Criação do usuário no Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Criação de um novo UserModel com as informações fornecidas
        UserModel newUser = UserModel(
          id: user.uid, // O UID retornado pela autenticação
          nome: nome, // Nome do usuário
          email: email, // Email do usuário
          userType: userType, // Tipo do usuário (Admin ou Representante)
          institutionId: institutionId, // ID da Instituição
          turmaId: turmaId, // ID da turma (se for Representante)
          isActive: true, // Usuário está ativo por padrão
        );

        // Definir a coleção e o caminho correto de acordo com o tipo de usuário
        String docId = userType == 'admin' ? 'admin' : turmaId ?? user.uid;

        // Salvando os dados do usuário no Firestore na estrutura correta
        await _firestore
            .collection('institutions')               // Acessa a coleção de instituições
            .doc(institutionId)                       // Documento da instituição
            .collection('turmas')                     // Subcoleção "turmas"
            .doc(docId)                               // Documento da turma ou admin
            .set(newUser.toMap());                    // Insere os dados do usuário

        // Atualiza o estado local do UserModel
        _userModel = newUser;
        notifyListeners();

        print('Usuário registrado com sucesso e salvo no Firestore.');
      } else {
        print("Erro: o usuário não foi criado no Firebase Auth.");
      }
    } catch (e) {
      print("Erro no registro: $e");
      throw e; // Propaga o erro para tratamento posterior
    }
  }

  
  

  
  // // Função para registrar um novo usuário
  // Future<void> registerWithEmail(
  //     String nome, String email, String password, String userType, String institutionId,
  //     {String? turmaId}) async {
  //   try {
  //     // Criação do usuário no Firebase Auth
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     User? user = userCredential.user;

  //     if (user != null) {
  //       // Criação de um novo UserModel com as informações fornecidas
  //       UserModel newUser = UserModel(
  //         id: user.uid, // O UID retornado pela autenticação
  //         nome: nome, // Nome do usuário
  //         email: email, // Email do usuário
  //         userType: userType, // Tipo do usuário (Admin ou Representante)
  //         institutionId: institutionId, // ID da Instituição
  //         turmaId: turmaId, // ID da turma (se for Representante)
  //         isActive: true, // Usuário está ativo por padrão
  //       );

  //       // Salvando os dados do usuário no Firestore dentro de 'users', utilizando o UID do Firebase Auth
  //       await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

  //       // Atualiza o estado local do UserModel
  //       _userModel = newUser;
  //       notifyListeners();

  //       print('Usuário registrado com sucesso e salvo no Firestore.');
  //     } else {
  //       print("Erro: o usuário não foi criado no Firebase Auth.");
  //     }
  //   } catch (e) {
  //     print("Erro no registro: $e");
  //     throw e; // Propaga o erro para tratamento posterior
  //   }
  // }

  // Logout
  Future<void> logOut() async {
    await _auth.signOut();
    _userModel = null;
    notifyListeners();
  }
  
  // Função de Login
  Future<void> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      
      if (user != null) {
        // Buscar os dados do usuário no Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          _userModel = UserModel.fromFirestore(userDoc.data() as Map<String, dynamic>, user.uid);
          _institutionId = userDoc.get('institutionId'); // Associar instituição
          notifyListeners();
        }
      }
    } catch (e) {
      print("Erro no login: $e");
    }
  }

  // Future<void> registerWithEmail(String nome, String email, String password, String userType, String institutionId, {String? turmaId}) async {
  //   try {
  //     // Criação do usuário no Firebase Auth
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     User? user = userCredential.user;

  //     if (user != null) {
  //       // Criação de um novo UserModel com as informações fornecidas
  //       UserModel newUser = UserModel(
  //         id: user.uid,  // O UID retornado pela autenticação
  //         nome: nome,    // Nome do usuário
  //         email: email,  // Email do usuário
  //         userType: userType, // Tipo do usuário (Admin ou Representante)
  //         institutionId: institutionId, // ID da Instituição
  //         turmaId: turmaId, // ID da turma (se for Representante)
  //         isActive: true, // Usuário está ativo por padrão
  //       );

  //       // Salvando os dados do usuário no Firestore
  //       await _firestore
  //           .collection('institutions')
  //           .doc(institutionId)
  //           .collection('users')
  //           .doc(user.uid)  // Usando o UID como chave para o documento
  //           .set(newUser.toMap());

  //       // Atualiza o estado local do UserModel
  //       _userModel = newUser;
  //       notifyListeners();

  //       print('Usuário registrado com sucesso e salvo no Firestore.');
  //     } else {
  //       print("Erro: o usuário não foi criado no Firebase Auth.");
  //     }
  //   } catch (e) {
  //     print("Erro no registro: $e");
  //     throw e;  // Propaga o erro para tratamento posterior
  //   }
  // }

  // // Logout
  // Future<void> logOut() async {
  //   await _auth.signOut();
  //   _userModel = null;
  //   notifyListeners();
  // }
  }