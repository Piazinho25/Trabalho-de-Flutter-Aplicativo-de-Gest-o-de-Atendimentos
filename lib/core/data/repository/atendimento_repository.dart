import '../../util/database.dart';
import '../../domain/model/atendimento_model.dart';
import '../../domain/contract/i_atendimento_repository.dart';

class AtendimentoRepository implements IAtendimentoRepository{
  final db=DatabaseHelper.instance;

  @override
  Future<List<AtendimentoModel>> getAll() async{
    final conn=await db.database;
    final res=await conn.query('atendimentos', orderBy:'id DESC');
    return res.map((e)=>AtendimentoModel.fromMap(e)).toList();
  }

  @override
  Future<int> create(AtendimentoModel m) async{
    final conn=await db.database;
    return conn.insert('atendimentos', m.toMap());
  }

  @override
  Future<int> update(AtendimentoModel m) async{
    final conn=await db.database;
    return conn.update('atendimentos', m.toMap(), where:'id=?', whereArgs:[m.id]);
  }

  @override
  Future<int> delete(int id) async{
    final conn=await db.database;
    return conn.delete('atendimentos', where:'id=?', whereArgs:[id]);
  }
}
