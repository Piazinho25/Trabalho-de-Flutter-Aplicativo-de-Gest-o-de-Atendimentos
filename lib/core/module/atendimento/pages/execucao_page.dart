import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/atendimento_model.dart';
import '../controller/atendimento_controller.dart';

class ExecucaoAtendimentoPage extends StatefulWidget {
  final AtendimentoModel model;

  const ExecucaoAtendimentoPage(this.model, {super.key});

  @override
  State<ExecucaoAtendimentoPage> createState() => _ExecucaoAtendimentoPageState();
}

class _ExecucaoAtendimentoPageState extends State<ExecucaoAtendimentoPage> {
  File? imgFinal;
  final _obs = TextEditingController();

  Future _pickImg() async {
    final x = await ImagePicker().pickImage(source: ImageSource.camera);
    if (x != null) {
      setState(() => imgFinal = File(x.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.read<AtendimentoController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Execução"),
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              widget.model.titulo,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // FOTO FINAL
            GestureDetector(
              onTap: _pickImg,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                  image: imgFinal != null
                      ? DecorationImage(image: FileImage(imgFinal!), fit: BoxFit.cover)
                      : null,
                ),
                child: imgFinal == null
                    ? const Center(child: Icon(Icons.camera_alt, size: 40))
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _obs,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Observações",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 112, 119, 113),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                final m = AtendimentoModel(
                  id: widget.model.id,
                  titulo: widget.model.titulo,
                  descricao:
                      "${widget.model.descricao}\nExecução: ${_obs.text}",
                  imagePath: imgFinal?.path ?? widget.model.imagePath,
                  status: "finalizado",
                  createdAt: widget.model.createdAt,
                );

                c.concluir(m);
                Navigator.pop(context);
              },
              child: const Text(
                "Finalizar Atendimento",
                style: TextStyle(
                  fontSize: 16,
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
