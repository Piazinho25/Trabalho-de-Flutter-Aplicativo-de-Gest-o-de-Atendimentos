import '../model/atendimento_model.dart';

abstract class IAtendimentoRepository{
  Future<List<AtendimentoModel>> getAll();
  Future<int> create(AtendimentoModel m);
  Future<int> update(AtendimentoModel m);
  Future<int> delete(int id);
}
