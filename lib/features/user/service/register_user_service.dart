// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../model/user_model.dart';

// class FirebaseService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;


//   // Função para registrar o usuário e salvar no Firestore
//   Future<void> registerWithEmail(
//     String nome, // Adiciona o campo nome
//     String email,
//     String password,
//     String userType,
//     String institutionId, // Código da Instituição
//     {String? turmaId} // Código da Turma para Representante, opcional
//   ) async {
//     try {
//       // Autenticação no Firebase
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       User? user = userCredential.user;

//       if (user != null) {
//         // Criar um novo modelo de usuário com nome incluído
//         UserModel newUser = UserModel(
//           id: user.uid,
//           nome: nome, // Adicionando o nome ao modelo de usuário
//           email: email,
//           userType: userType,
//           institutionId: institutionId, // Associar à instituição
//           turmaId: turmaId,
//           isActive: true,
//         );

//         // Salvar no Firestore na coleção de users
//         await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

//         // Atualiza o estado do usuário autenticado
//         _userModel = newUser;
//         notifyListeners();
//       }
//     } catch (e) {
//       print("Erro no registro: $e");
//     }
//   }

//   // Função para verificar se o usuário está logado
//   bool get isLoggedIn => _auth.currentUser != null;


// // Função para registrar um usuário em uma instituição
//   Future<void> registerUserInInstitution(
//       String institutionId, String userId, Map<String, dynamic> userData) async {
//     try {
//       await _firestore
//           .collection('institutions') // Acessa a coleção principal
//           .doc(institutionId) // Usa o ID da instituição
//           .collection('users') // Subcoleção de usuários dentro da instituição
//           .doc(userId) // Identifica o documento do usuário
//           .set(userData); // Armazena os dados do usuário
//     } catch (e) {
//       print('Erro ao registrar usuário na instituição: $e');
//     }
//   }

//   // Função para obter dados de uma turma de uma instituição específica
//   Future<DocumentSnapshot> getTurmaData(String institutionId, String turmaId) async {
//     try {
//       return await _firestore
//           .collection('institutions')
//           .doc(institutionId)
//           .collection('turmas')
//           .doc(turmaId)
//           .get();
//     } catch (e) {
//       print('Erro ao recuperar dados da turma: $e');
//       rethrow;
//     }
//   }
  
  
//   // Login com email e senha
//   Future<User?> loginWithEmail(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Erro no login: $e");
//       return null;
//     }
//   }

//   // Logout
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // Obter o tipo de usuário do Firestore
//   Future<String?> getUserType(User user) async {
//     try {
//       DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
//       if (doc.exists) {
//         return doc['userType'];
//       }
//       return null;
//     } catch (e) {
//       print("Erro ao obter tipo de usuário: $e");
//       return null;
//     }
//   }
// }
