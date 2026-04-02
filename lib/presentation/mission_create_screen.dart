import 'package:flutter/material.dart';

/// Tela para criar uma nova missão.
class MissionCreateScreen extends StatefulWidget {
  const MissionCreateScreen({super.key});

  @override
  State<MissionCreateScreen> createState() => _MissionCreateScreenState();
}

class _MissionCreateScreenState extends State<MissionCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para os campos do formulário
  late TextEditingController _nameController;
  late TextEditingController _launchDateController;
  late TextEditingController _statusController;

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _launchDateController = TextEditingController();
    _statusController = TextEditingController();
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
        title: const Text('Cadastrar Missão'),
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
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty
                            ? 'Informe o nome.'
                            : null,
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
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty
                            ? 'Informe a data.'
                            : null,
              ),
              const SizedBox(height: 16),
              // Campo para o status da missão
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  hintText: 'Ativa/Concluída/Cancelada',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty
                            ? 'Informe o status.'
                            : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : (){

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child:
                      _isSubmitting
                          ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
