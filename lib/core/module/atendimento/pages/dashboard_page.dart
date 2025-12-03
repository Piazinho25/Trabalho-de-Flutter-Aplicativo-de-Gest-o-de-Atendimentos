import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/atendimento_controller.dart';
import 'atendimento_form_page.dart';
import 'execucao_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Color _statusColor(String status) {
    if (status.toLowerCase() == "ativo") {
      return Colors.green;
    }
    return Colors.blue;
  }

  Color _statusBackground(String status) {
    if (status.toLowerCase() == "ativo") {
      return Colors.green.withOpacity(0.2);
    }
    return Colors.blue.withOpacity(0.2);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AtendimentoController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text(
          "Atendimentos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 104, 179, 240),
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AtendimentoFormPage()),
          );
        },
      ),
      body: c.lista.isEmpty
          ? const Center(
              child: Text(
                "Nenhum atendimento cadastrado.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: c.lista.length,
              itemBuilder: (_, i) {
                final a = c.lista[i];

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: () {
                          if (a.status.toLowerCase() == "finalizado") {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(22),
                                ),
                              ),
                              builder: (_) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (a.imagePath != null)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.file(
                                            File(a.imagePath!),
                                            height: 220,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                      const SizedBox(height: 20),

                                      Text(
                                        "Observação Final",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      Text(
                                        a.descricao.contains("\n")
                                            ? a.descricao.split("\n").last
                                            : a.descricao,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),

                                      const SizedBox(height: 25),
                                    ],
                                  ),
                                );
                              },
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ExecucaoAtendimentoPage(a),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (a.imagePath != null)
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: Image.file(
                                  File(a.imagePath!),
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a.titulo,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    a.descricao.contains("\n")
                                        ? a.descricao.split("\n").last
                                        : a.descricao,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _statusBackground(a.status),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      a.status.toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _statusColor(a.status),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AtendimentoFormPage(
                                      model: a,
                                      isEdit: true,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 22,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () async {
                                final confirm = await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text("Excluir atendimento"),
                                      content: const Text(
                                        "Tem certeza que deseja excluir este atendimento?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text("Cancelar"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            "Excluir",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  c.remove(a.id!);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  size: 22,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
