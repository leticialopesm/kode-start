import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/character_list_provider.dart';
import '../widgets/character_card.dart';
import 'character_detail_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carregar a primeira página
    Future.microtask(
      () => context.read<CharacterListProvider>().fetchFirstPage(),
    );
    // Paginação infinita
    _controller.addListener(() {
      final CharacterListProvider provider =
          context.read<CharacterListProvider>();
      final bool nearEnd = _controller.position.pixels >=
          _controller.position.maxScrollExtent - 300;
      if (nearEnd && provider.hasMore && !provider.loading) {
        provider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CharacterListProvider provider = context.watch<CharacterListProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141418),
        elevation: 0,
        toolbarHeight: 72,
        centerTitle: true,

        // Ícone de menu (asset)
        leading: IconButton(
          onPressed: () {
            // TODO: abrir Drawer / menu lateral
          },
          padding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          splashRadius: 24,
          icon: Image.asset(
            'assets/images/icon_menu.png',
            width: 32,
            height: 32,
          ),
        ),

        // Logo + título
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', height: 20),
            const SizedBox(height: 6),
            const Text(
              'RICK AND MORTY API',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
          ],
        ),

        // Ícone de perfil (asset)
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                // TODO: abrir tela de perfil
              },
              child: Image.asset(
                'assets/images/icon_profile.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Campo de busca
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Buscar por nome:',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (String text) {
                      context
                          .read<CharacterListProvider>()
                          .fetchFirstPage(search: text);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    context
                        .read<CharacterListProvider>()
                        .fetchFirstPage(search: _searchCtrl.text);
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
          ),

          // Divisor leve
          const Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16),

          // Lista de personagens
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => provider.fetchFirstPage(search: provider.search),
              child: Builder(
                builder: (_) {
                  if (provider.loading && provider.items.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.error && provider.items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Falha ao carregar.'),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () => provider.fetchFirstPage(
                              search: provider.search,
                            ),
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _controller,
                    itemCount:
                        provider.items.length + (provider.hasMore ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= provider.items.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final character = provider.items[index];

                      // >>>>>>  AQUI passa o id para o card (Hero tag)  <<<<<<
                      return CharacterCard(
                        id: character.id,
                        name: character.name,
                        imageUrl: character.image,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CharacterDetailPage(
                                id: character.id,
                                name: character.name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
