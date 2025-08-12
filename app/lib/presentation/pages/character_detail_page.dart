import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/character_detail_provider.dart';

// use sua constante global se já existir
const Color kPurple = Color(0xFF87A1FA);

class CharacterDetailPage extends StatefulWidget {
  final int id;
  final String name;

  const CharacterDetailPage({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  bool isPortuguese = false;

  // ======================================================
  // DICIONÁRIO PERSONALIZADO (tem prioridade na tradução)
  // ======================================================
  final Map<String, String> _customTranslations = {
    // ----- Status -----
    'Alive': 'Vivo',
    'Dead': 'Morto',
    'unknown': 'Desconhecido',

    // ----- Gênero -----
    'Male': 'Masculino',
    'Female': 'Feminino',
    'Genderless': 'Sem Gênero',

    // ----- Espécies genéricas -----
    'Human': 'Humano',
    'Humans': 'Humanos',
    'Alien': 'Alienígena',
    'Humanoid': 'Humanoide',
    'Robot': 'Robô',
    'Animal': 'Animal',
    'Disease': 'Doença',
    'Cronenberg': 'Cronenberg',
    'Cronenbergs': 'Cronenbergs',
    'Mythological Creature': 'Criatura Mitológica',

    // ----- Raças específicas -----
    'Gromflomites': 'Gromflomitas',
    'Meeseeks': 'Meeseeks',
    'Gazorpians': 'Gazorpianos',
    'Cromulons': 'Cromulons',
    'Gear People': 'Pessoas-Engrenagem',
    'Plutonians': 'Plutonianos',
    'Memory Parasites': 'Parasitas da Memória',
    'Birdperson': 'Homem-Pássaro',
    'Squanchy': 'Squanchy',
    'Fart': 'Fart',
    'Unity': 'Unity',
    'Krootabulons': 'Krootabulons',
    'Floop-Flops': 'Floop-Flops',
    'Zigerions': 'Zigerianos',
    'Glootie': 'Glootie',

    // ----- Locais comuns -----
    'Earth': 'Terra',
    'Dimension C-137': 'Dimensão C-137',
    'Replacement Dimension': 'Dimensão Substituta',
    'Post-Apocalyptic Dimension': 'Dimensão Pós-Apocalíptica',
    'Dimension 35-C': 'Dimensão 35-C',
    'Citadel of Ricks': 'Cidadela dos Ricks',
    'Bird World': 'Mundo dos Pássaros',
    'Planet Squanch': 'Planeta Squanch',
    'Interdimensional Cable': 'Cabo Interdimensional',

    // ----- Episódios (S01) -----
    'Pilot': 'Piloto',
    'Lawnmower Dog': 'Cãortador de Grama',
    'Anatomy Park': 'Parque das Bactérias',
    'M. Night Shaym-Aliens!': 'Realidade Virtual',
    'Meeseeks and Destroy': 'A Revolta dos Meeseeks',
    'Rick Potion #9': 'A Poção do Rick',
    'Raising Gazorpazorp': 'O Pequeno Gazorpazorp',
    'Rixty Minutes': 'Realidade Alternativa',
    'Something Ricked This Way Comes': 'Uma Loja do Diabo',
    'Close Rick-counters of the Rick Kind': 'Contatos Imediatos',
    'Ricksy Business': 'Negócio Arriscado',

    // ----- Episódios (S02) -----
    'A Rickle in Time': 'Um Rick no Tempo',
    'Mortynight Run': 'Corra Morty, Corra',
    'Auto Erotic Assimilation': 'Assimilação Autoerótica',
    'Total Rickall': 'Recordar é Viver',
    'Get Schwifty': 'Get Schwifty',
    'The Ricks Must Be Crazy': 'Os Ricks Devem Estar Loucos',
    'Big Trouble in Little Sanchez': 'Grande Problema no Pequeno Sanchez',
    'Interdimensional Cable 2: Tempting Fate': 'TV Interdimensional 2: Tentando o Destino',
    'Look Who\'s Purging Now': 'Quem Está Purgando Agora',
    'The Wedding Squanchers': 'O Casamento dos Squanchers',

    // ----- Episódios (S03) -----
    'The Rickshank Redemption': 'A Redenção de Rick',
    'Rickmancing the Stone': 'O Romance da Pedra',
    'Pickle Rick': 'Pickle Rick',
    'Vindicators 3: The Return of Worldender': 'Vindicadores 3: O Retorno do Fim do Mundo',
    'The Whirly Dirly Conspiracy': 'A Conspiração Whirly Dirly',
    'Rest and Ricklaxation': 'Descanso e Ricklaxamento',
    'The Ricklantis Mixup': 'O Mix-Up da Ricklântida',
    'Morty\'s Mind Blowers': 'A Explosão de Memórias de Morty',
    'The ABC\'s of Beth': 'O ABC de Beth',
    'The Rickchurian Mortydate': 'O Candidato Rickchuriano',

    // ----- Episódios (S04) -----
    'Edge of Tomorty: Rick Die Rickpeat': 'No Limite do Amanhã: Rick Morra Rickparte',
    'The Old Man and the Seat': 'O Velho e o Assento',
    'One Crew over the Crewcoo\'s Morty': 'Um Bando Sobre o Ninho de Morty',
    'Claw and Hoarder: Special Ricktim\'s Morty': 'Garra e Saqueador: Unidade de Vítimas Especiais',
    'Rattlestar Ricklactica': 'Rattlestar Ricklactica',
    'Never Ricking Morty': 'Uma Aventura Nunca Ricksbosa',
    'Promortyus': 'Promortyus',
    'The Vat of Acid Episode': 'O Episódio do Tanque de Ácido',
    'Childrick of Mort': 'A Filharrickada de Mort',
    'Star Mort Rickturn of the Jerri': 'Star Mort: O Ricktorno de Jerri',

    // ----- Episódios (S05) -----
    'Mort Dinner Rick Andre': 'Jantar de Mort Rick Andre',
    'Mortyplicity': 'Mortyplicidade',
    'A Rickconvenient Mort': 'Um Mort Inconveniente',
    'Rickdependence Spray': 'Rickdependência Spray',
    'Amortycan Grickfitti': 'Grafite Americkano',
    'Rick & Morty\'s Thanksploitation Spectacular': 'Rick e Morty e o Espetacular Thanksploitation',
    'Gotron Jerrysis Rickvangelion': 'Gotron Jerrysis Rickvangelion',
    'Rickternal Friendshine of the Spotless Mort': 'Brilho Rickterno de uma Mente sem Mort',
    'Forgetting Sarick Mortshall': 'Esquecendo Sarick Mortshall',
    'Rickmurai Jack': 'Rickmurai Jack',

    // ----- Episódios (S06) -----
    'Bethic Twinstinct': 'Bethstinto Gêmeo',
    'Rick: A Mort Well Lived': 'Rick: Uma Mort Bem Vivida',
    'Beth\'s Fake-cation': 'As Férias Falsas de Beth',
    'A-Rick-Tastic-Voyage': 'Uma Viagem MaravilRickosa',
    'Final DeSmithation': 'Destinação DeSmithfinal',
    'JuRicksic Mort': 'JuRicksic Mort',
    'Full Meta Jackrick': 'O Jackrick Meta Completo',
    'Analyze Piss': 'Analise Mijo',
    'A Rick in King Mortur\'s Court': 'Um Rick na Corte do Rei Mortur',
    'Ricktional Mortpoon\'s Rickmas Mortcation': 'As Férias de Natal do Mortpão Rickciona',

    // ----- Episódios (S07) -----
    'How Poopy Got His Poop Back': 'Como o Senhor Pecepepê Recompôs o Cocô',
    'The Jerrick Trap': 'A Armadilha de Jerrick',
    'Air Force Wong': 'Força Aérea Wong',
    'That\'s Amorte': 'Isso É Amorte',
    'Unmortricken': 'Desmortecido',
    'Rickfending Your Mort': 'Rickfendendo Seu Mort',
    'Wet Kuat Amortican Summer': 'Verão Amorticano de Kuat Molhado',
    'Rise of the Numbericons: The Movie': 'A Ascensão dos Numbericons: O Filme',
    'Mort: Ragnarick': 'Mort: Ragnarick',
    'Fear No Mort': 'Não Tema o Mort',
  };

  // ======================================================
  // Fallback por palavra para quando não houver no dicionário
  // ======================================================
  static const Map<String, String> _wordMap = {
    'earth': 'terra',
    'dimension': 'dimensão',
    'replacement': 'substituição',
    'post-apocalyptic': 'pós-apocalíptica',
    'planet': 'planeta',
    'galaxy': 'galáxia',
    'city': 'cidade',
    'council': 'conselho',
    'federation': 'federação',
    'hospital': 'hospital',
    'school': 'escola',
    'university': 'universidade',
    'space': 'espaço',
    'time': 'tempo',
    'of': 'de',
    'the': 'o',
    'and': 'e',
    'unknown': 'desconhecida',
  };

  String _matchCase(String src, String dstLower) {
    if (src.isEmpty) return dstLower;
    if (src.toUpperCase() == src) return dstLower.toUpperCase();
    if (src[0].toUpperCase() == src[0]) {
      return dstLower[0].toUpperCase() + dstLower.substring(1);
    }
    return dstLower;
  }

  String _translateLoose(String text) {
    // 1) dicionário personalizado (match exato)
    final direct = _customTranslations[text];
    if (direct != null) return direct;

    // 2) tokenização simples preservando separadores
    final reg = RegExp(r'(\w+|\W+)');
    final tokens = reg
        .allMatches(text)
        .map((m) => m.group(0)!)
        .toList(growable: false);

    final translated = tokens.map((t) {
      if (RegExp(r'^\w+$').hasMatch(t)) {
        final lower = t.toLowerCase();
        final mapped = _wordMap[lower];
        if (mapped != null) return _matchCase(t, mapped);
      }
      return t;
    }).join();

    // 3) pós-ajustes
    return translated
        .replaceAll('  ', ' ')
        .replaceAll('De O', 'Do')
        .replaceAll('de o', 'do')
        .replaceAll('De A', 'Da')
        .replaceAll('de a', 'da');
  }

  String _trDynamic(String text) => isPortuguese ? _translateLoose(text) : text;

  // Labels fixos
  String _labelGender() => isPortuguese ? 'Gênero:' : 'Gender:';
  String _labelOrigin() => isPortuguese ? 'Origem:' : 'Origin:';
  String _labelLastLocation() =>
      isPortuguese ? 'Última localização:' : 'Last know location:';
  String _labelFirstSeen() =>
      isPortuguese ? 'Primeira aparição:' : 'First seen in:';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharacterDetailProvider()..load(widget.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF141418),
          elevation: 0,
          toolbarHeight: 72,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            splashRadius: 24,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/images/icon_profile.png',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ],
        ),
        body: Consumer<CharacterDetailProvider>(
          builder: (context, prov, _) {
            if (prov.loading || prov.character == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final c = prov.character!;

            final originText = _trDynamic(c.originName);
            final locationText = _trDynamic(c.locationName);
            final firstEpText = _trDynamic(prov.firstAppearance ?? '—');

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kPurple,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: Image.network(
                              c.image,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (isPortuguese ? _trDynamic(c.name) : c.name)
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: c.status.toLowerCase() == 'alive'
                                          ? Colors.greenAccent
                                          : (c.status.toLowerCase() == 'dead'
                                              ? Colors.redAccent
                                              : Colors.orangeAccent),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${_trDynamic(c.status)} - ${_trDynamic(c.species)}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _label(_labelGender()),
                              _value(_trDynamic(c.gender)),
                              const SizedBox(height: 16),
                              _label(_labelOrigin()),
                              _value(originText),
                              const SizedBox(height: 16),
                              _label(_labelLastLocation()),
                              _value(locationText),
                              const SizedBox(height: 16),
                              _label(_labelFirstSeen()),
                              _value(firstEpText),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Material(
                      color: const Color(0xFF141418),
                      shape: const CircleBorder(),
                      elevation: 3,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          setState(() {
                            isPortuguese = !isPortuguese;
                          });
                        },
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Center(
                            child: Icon(Icons.translate, color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 18,
                    right: 64,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isPortuguese ? 'PT-BR' : 'EN',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _label(String t) => Text(
        t,
        style: TextStyle(
          color: Colors.white.withOpacity(0.75),
          fontSize: 14,
        ),
      );

  Widget _value(String t) => Text(
        t,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );
}
