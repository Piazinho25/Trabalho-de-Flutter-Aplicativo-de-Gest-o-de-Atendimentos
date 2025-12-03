import '../contract/i_atendimento_repository.dart';
class DeleteAtendimento{
  final IAtendimentoRepository repo;DeleteAtendimento(this.repo);Future<int> call(int id)=>repo.delete(id);
  }