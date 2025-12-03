import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/atendimento_model.dart';
import '../controller/atendimento_controller.dart';

class AtendimentoFormPage extends StatefulWidget {
  final AtendimentoModel? model;
  final bool isEdit;

  const AtendimentoFormPage({super.key, this.model, this.isEdit = false});

  @override
  State<AtendimentoFormPage> createState() => _AtendimentoFormPageState();
}

class _AtendimentoFormPageState extends State<AtendimentoFormPage> {
  final _titulo = TextEditingController();
  final _descricao = TextEditingController();
  File? img;
  bool finalizado = false;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.model != null) {
      final m = widget.model!;
      finalizado = m.status.toLowerCase() == "finalizado";

      _titulo.text = m.titulo;
      _descricao.text = m.descricao.contains("\n")
          ? m.descricao.split("\n").last.replaceFirst("Execução: ", "")
          : m.descricao;

      if (m.imagePath != null) {
        img = File(m.imagePath!);
      }
    }
  }

  Future _pickImg() async {
    if (finalizado) return;

    final x = await ImagePicker().pickImage(source: ImageSource.camera);
    if (x != null) {
      setState(() => img = File(x.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.read<AtendimentoController>();

    final editando = widget.isEdit && widget.model != null;
    final tituloPagina = editando ? "Editar Atendimento" : "Novo Atendimento";

    return Scaffold(
      appBar: AppBar(
        title: Text(tituloPagina),
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _titulo,
              enabled: !finalizado,
              decoration: InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _descricao,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: finalizado ? "Observação Final" : "Descrição",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: _pickImg,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 172, 185, 204),
                  borderRadius: BorderRadius.circular(16),
                  image: img != null
                      ? DecorationImage(
                          image: FileImage(img!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: img == null
                    ? const Center(
                        child: Icon(Icons.camera_alt, size: 40),
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 112, 119, 113),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (editando) {
                  final m = widget.model!;
                  final novaDescricao =
                      "${m.descricao.split('\n').first}\nExecução: ${_descricao.text}";

                  final atualizado = AtendimentoModel(
                    id: m.id,
                    titulo: finalizado ? m.titulo : _titulo.text,
                    descricao: finalizado ? novaDescricao : _descricao.text,
                    imagePath: finalizado ? m.imagePath : img?.path,
                    status: m.status,
                    createdAt: m.createdAt,
                  );

                  c.edit(atualizado);
                } else {
                  final novo = AtendimentoModel(
                    titulo: _titulo.text,
                    descricao: _descricao.text,
                    imagePath: img?.path,
                    status: "ativo",
                    createdAt: DateTime.now().toIso8601String(),
                  );

                  c.add(novo);
                }

                Navigator.pop(context);
              },
              child: Text(
                editando
                    ? (finalizado ? "Salvar Observação" : "Salvar Alterações")
                    : "Criar Atendimento",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
