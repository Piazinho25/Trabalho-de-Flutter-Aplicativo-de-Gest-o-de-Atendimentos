class AtendimentoModel {
  final int? id;
  final String titulo;
  final String descricao;
  final String? imagePath;
  final String status;
  final String createdAt;

  AtendimentoModel({
    this.id,
    required this.titulo,
    required this.descricao,
    this.imagePath,
    required this.status,
    required this.createdAt,
  });

  factory AtendimentoModel.fromMap(Map<String,dynamic> map)=>AtendimentoModel(
    id:map['id'],
    titulo:map['titulo'],
    descricao:map['descricao'],
    imagePath:map['imagePath'],
    status:map['status'],
    createdAt:map['createdAt'],
  );

  Map<String,dynamic> toMap()=> {
    'id':id,
    'titulo':titulo,
    'descricao':descricao,
    'imagePath':imagePath,
    'status':status,
    'createdAt':createdAt
  };
}
