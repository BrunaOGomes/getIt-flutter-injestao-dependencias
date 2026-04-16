import 'package:flutter/material.dart';
import 'package:injestao_dependencias/domain/mission_model.dart';
import 'package:injestao_dependencias/presentation/mission_view_model.dart';
import 'package:provider/provider.dart';

/// Tela para criar uma nova missão.
class MissionCreateScreen extends StatefulWidget {
  const MissionCreateScreen({super.key});

  @override
  State<MissionCreateScreen> createState() => _MissionCreateScreenState();
}

//aqui vive a logica
class _MissionCreateScreenState extends State<MissionCreateScreen> {
  //controla o form,valida tudo de uma vez
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para os campos do formulário
  late TextEditingController _nameController;
  late TextEditingController _launchDateController;
  late TextEditingController _statusController;

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  //executa quando a tela abre
  void initState() {
    super.initState();
    //inicializa campos vazios
    _nameController = TextEditingController();
    _launchDateController = TextEditingController();
    _statusController = TextEditingController();
  }

  @override
  void dispose() {
    //libera a memoria / evita vazamento de dados
    _nameController.dispose();
    _launchDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    // Aqui você pode buscar os dados necessários para preencher os campos do formulário,
    // como opções de status ou outras informações relevantes.
    //se tiver erro saia se nao tiver entra aqui
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'Por favor, preencha todos os campos corretamente.'; 
      });
      final mission = MissionModel(
        id: 0,
        name: _nameController.text,
        launchDate: _launchDateController.text,
        status: _statusController.text,
      );
      final vm = context.read<MissionViewModel>();
      await vm.createMission(mission);
      setState(() {
        _isSubmitting = false;
        _errorMessage = null;
      });

      Navigator.of(context).pop();
    }
  }

  @override
  //constroi a ui
  Widget build(BuildContext context) {
    //estrutura da tela
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Missão'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        //formulario
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
                validator: (val) => val == null || val.trim().isEmpty
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
                validator: (val) => val == null || val.trim().isEmpty
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
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Informe o status.'
                    : null,
              ),
              //espaço vertical
              const SizedBox(height: 32),
              //ocupa toda a largura disponivel
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  //Se estiver enviando (_isSubmitting == true), desabilita o botão
                  //Caso contrário, permite o clique
                  onPressed: _isSubmitting ? null : () {
                    getData();
                  },
                  //estilo do botao
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: _isSubmitting
                      //enquanto estiver enviando,mostra um loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2, //espessura do spinner
                            color: Colors.white,
                          ),
                        )
                      //Caso contrário, mostra o texto do botão
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
