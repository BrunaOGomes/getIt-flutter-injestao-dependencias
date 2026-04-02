import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/mission_model.dart';
import 'mission_view_model.dart';

/// Tela responsável pela edição de uma missão existente.
class MissionEditScreen extends StatefulWidget {
  const MissionEditScreen({super.key, required this.mission});

  /// Missão que será editada.
  final MissionModel mission;

  @override
  State<MissionEditScreen> createState() => _MissionEditScreenState();
}

class _MissionEditScreenState extends State<MissionEditScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para preencher e editar os dados
  late TextEditingController _nameController;
  late TextEditingController _launchDateController;
  late TextEditingController _statusController;

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final m = widget.mission;
    _nameController = TextEditingController(text: m.name);
    _launchDateController = TextEditingController(text: m.launchDate);
    _statusController = TextEditingController(text: m.status);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _launchDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar #${widget.mission.id}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Exibe mensagem de erro se houver
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              // Campo para o nome da missão
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da missão',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Informe o nome.' : null,
              ),
              const SizedBox(height: 16),
              // Campo para a data de lançamento
              TextFormField(
                controller: _launchDateController,
                decoration: const InputDecoration(
                  labelText: 'Data de lançamento',
                  hintText: 'YYYY-MM-DD',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Informe a data.' : null,
              ),
              const SizedBox(height: 16),
              // Campo para o status da missão
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  hintText: 'planned / in_progress / active …',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Informe o status.'
                    : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null :(){ },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Salvar alterações'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
