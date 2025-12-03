import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/module/atendimento/controller/atendimento_controller.dart';
import 'core/domain/usecase/get_atendimentos.dart';
import 'core/domain/usecase/create_atendimento.dart';
import 'core/domain/usecase/update_atendimento.dart';
import 'core/domain/usecase/delete_atendimento.dart';
import 'core/domain/usecase/finalizar_atendimento.dart';
import 'core/data/repository/atendimento_repository.dart';
import 'core/module/atendimento/pages/dashboard_page.dart';

void main(){
  final repo=AtendimentoRepository();
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create:(_)=>AtendimentoController(
            getAll:GetAtendimentos(repo),
            create:CreateAtendimento(repo),
            update:UpdateAtendimento(repo),
            delete:DeleteAtendimento(repo),
            finalizar:FinalizarAtendimento(repo),
          ),
        ),
      ],
      child:const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override Widget build(BuildContext context){
    return MaterialApp(
      home:DashboardPage(),
    );
  }
}
