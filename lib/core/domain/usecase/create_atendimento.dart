import '../contract/i_atendimento_repository.dart';import '../model/atendimento_model.dart';
class CreateAtendimento{
  final IAtendimentoRepository repo;CreateAtendimento(this.repo);Future<int> call(AtendimentoModel m)=>repo.create(m);
  }