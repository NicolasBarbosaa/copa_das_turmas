class UserModel {
  String id; // Será o UID do Firebase Auth
  String nome; // Nome do usuário
  String email;
  String userType;
  bool isActive;
  String? turmaId;
  String? institutionId;
  String? profilePhoto;

  UserModel({
    required this.id,
    required this.nome, // Adiciona nome
    required this.email,
    required this.userType,
    required this.institutionId,
    this.isActive = true,
    this.turmaId,
    this.profilePhoto,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      nome: data['nome'], // Adiciona nome
      email: data['email'],
      userType: data['userType'],
      institutionId: data['institutionId'],
      isActive: data['isActive'] ?? true,
      turmaId: data['turmaId'],
      profilePhoto: data['profilePhoto'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome, // Adiciona nome
      'email': email,
      'userType': userType,
      'isActive': isActive,
      'turmaId': turmaId,
      'institutionId': institutionId,
      'profilePhoto': profilePhoto,
    };
  }
}
