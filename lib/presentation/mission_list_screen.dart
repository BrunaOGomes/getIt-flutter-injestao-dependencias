import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mission_create_screen.dart';
import 'mission_edit_screen.dart';
import 'mission_view_model.dart';

/// Tela principal que lista as missões espaciais da agência.
class MissionListScreen extends StatefulWidget {
  const MissionListScreen({super.key});

  @override
  State<MissionListScreen> createState() => _MissionListScreenState();
}

class _MissionListScreenState extends State<MissionListScreen> {
  late MissionViewModel _missionViewModel;

  @override
  void initState() {
    _missionViewModel = context.read<MissionViewModel>();
    _missionViewModel.loadMissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o ViewModel associado à lista de missões
    final vm = context.watch<MissionViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA - Missões'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<MissionViewModel>().loadMissions(),
          ),
        ],
      ),
      // Estrutura principal da tela, mostra loading, erro ou lista de missões
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          //erro
          : vm.errorMessage != null
          ? Center(child: Text(vm.errorMessage!))
          //lista
          : ListView.builder(
              itemCount: vm.missions.length,
              itemBuilder: (context, index) {
                //item da lista
                final mission = vm.missions[index];
                return ListTile(
                  // Exibe o ID da missão em um círculo
                  leading: CircleAvatar(child: Text('${mission.id}')),
                  title: Text(mission.name),
                  subtitle: Text(
                    'Lançamento: ${mission.launchDate} · ${mission.status}',
                  ),
                  // Menu de contexto da missão para editar ou excluir
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) async {
                      if (value == 'edit') {
                        // Navega para a tela de edição
                        await Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                MissionEditScreen(mission: mission),
                          ),
                        );
                      } else if (value == 'delete') {
                        // Exibe diálogo de confirmação de exclusão
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Excluir missão?'),
                            content: Text(
                              'Remover "${mission.name}" (id ${mission.id})?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Excluir'),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true && context.mounted) {
                          //TODO CHAMAR O DELETE AQUI
                          if (!context.mounted) return;
                          if (false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possível excluir.'),
                              ),
                            );
                          }
                        }
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 12),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 20),
                            SizedBox(width: 12),
                            Text('Excluir'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      //abre a tela de criacao
      // Botão flutuante que aparece no canto da tela
      floatingActionButton: FloatingActionButton(
        // Cor de fundo do botão (preto)
        backgroundColor: Colors.black,
        // Cor do ícone (branco)
        foregroundColor: Colors.white,
        // Texto de dica ao segurar ou passar o mouse
        tooltip: 'Adicionar missão',
        // Função executada ao clicar no botão
        onPressed: () {
          // Acessa o Navigator para trocar de tela
          Navigator.of(context).push(
            // Define a rota (tela) com estilo Material
            MaterialPageRoute<void>(
              // Builder constrói a nova tela
              builder: (context) => const MissionCreateScreen(),
            ),
          );
        },
        // Ícone exibido dentro do botão (+)
        child: const Icon(Icons.add),
      ),
    );
  }
}
