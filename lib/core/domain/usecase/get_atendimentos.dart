import '../contract/i_atendimento_repository.dart';
import '../model/atendimento_model.dart';
class GetAtendimentos{final IAtendimentoRepository repo;GetAtendimentos(this.repo);Future<List<AtendimentoModel>> call()=>repo.getAll();}