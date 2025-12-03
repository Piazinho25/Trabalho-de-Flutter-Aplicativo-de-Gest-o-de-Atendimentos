import 'package:flutter/material.dart';
import '../../../domain/model/atendimento_model.dart';
import '../../../domain/usecase/get_atendimentos.dart';
import '../../../domain/usecase/create_atendimento.dart';
import '../../../domain/usecase/update_atendimento.dart';
import '../../../domain/usecase/delete_atendimento.dart';
import '../../../domain/usecase/finalizar_atendimento.dart';

class AtendimentoController extends ChangeNotifier{
  final GetAtendimentos getAll;
  final CreateAtendimento create;
  final UpdateAtendimento update;
  final DeleteAtendimento delete;
  final FinalizarAtendimento finalizar;

  AtendimentoController({required this.getAll,required this.create,required this.update,required this.delete,required this.finalizar}){
    load();
  }

  List<AtendimentoModel> lista=[];
  bool loading=false;

  Future<void> load() async{
    loading=true;
    notifyListeners();
    lista=await getAll();
    loading=false;
    notifyListeners();
  }

  Future<void> add(AtendimentoModel m) async{await create(m);load();}
  Future<void> edit(AtendimentoModel m) async{await update(m);load();}
  Future<void> remove(int id) async{await delete(id);load();}
  Future<void> concluir(AtendimentoModel m) async{await finalizar(m);load();}
}
