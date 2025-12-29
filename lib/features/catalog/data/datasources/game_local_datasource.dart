// Mock data uses const-heavy structures; prefer_const_constructors is intentionally disabled here.
// ignore_for_file: prefer_const_constructors, public_member_api_docs

import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';

/// Local datasource for games (mock data matching the Vite.js prototype)
abstract class GameLocalDatasource {
  List<GameModel> getGames();
  GameModel? getGameById(int id);
  List<GameCategoryModel> getCategories();
  List<FilterShortcutModel> getFilterShortcuts();
}

@LazySingleton(as: GameLocalDatasource)
class GameLocalDatasourceImpl implements GameLocalDatasource {
  @override
  List<GameModel> getGames() => _mockGames;

  @override
  GameModel? getGameById(int id) {
    final matches = _mockGames.where((g) => g.id == id);
    return matches.isEmpty ? null : matches.first;
  }

  @override
  List<GameCategoryModel> getCategories() => _primaryCategories;

  @override
  List<FilterShortcutModel> getFilterShortcuts() => _filterShortcuts;
}

// Primary categories (from games.ts primaryCategories)
final List<GameCategoryModel> _primaryCategories = [
  const GameCategoryModel(
    id: 1,
    name: 'Familiar',
    icon: '👨‍👩‍👧‍👦',
    query: 'Familiar',
    description: 'Para todas las edades y grupos mixtos.',
  ),
  const GameCategoryModel(
    id: 2,
    name: 'Fiesta',
    icon: '🎉',
    query: 'Para previar',
    description: 'Para romper el hielo y reírse sin parar.',
  ),
  const GameCategoryModel(
    id: 3,
    name: 'Cooperativo',
    icon: '🤝',
    query: 'Cooperativo',
    description: 'Ganen (o pierdan) jugando en equipo.',
  ),
  const GameCategoryModel(
    id: 4,
    name: 'Estrategia',
    icon: '♟️',
    query: 'Estrategia',
    description: 'Planificá a fondo y tomá decisiones clave.',
  ),
  const GameCategoryModel(
    id: 5,
    name: 'Experto',
    icon: '🧠',
    query: 'Experto',
    description: 'Para quienes buscan partidas largas y desafiantes.',
  ),
  const GameCategoryModel(
    id: 6,
    name: 'Abstracto',
    icon: '🧩',
    query: 'Abstracto',
    description: 'Minimalistas, elegantes y relajados.',
  ),
];

// Filter shortcuts (from games.ts filterShortcuts)
final List<FilterShortcutModel> _filterShortcuts = [
  const FilterShortcutModel(id: 101, name: 'Dos jugadores', icon: '⚔️', type: 'players', value: '2'),
  const FilterShortcutModel(id: 102, name: 'Rolea y escribe', icon: '📝', type: 'query', query: 'Rolea y escribe'),
  const FilterShortcutModel(
    id: 103,
    name: 'Construcción de mazos',
    icon: '🃏',
    type: 'query',
    query: 'Construcción de mazos',
  ),
  const FilterShortcutModel(id: 104, name: 'Partidas cortas', icon: '⏱️', type: 'duration', value: 'lte30'),
  const FilterShortcutModel(id: 105, name: r'≤$50/día', icon: '💸', type: 'price', value: '50'),
];

// Mock games data (subset from games.ts for initial implementation)
final List<GameModel> _mockGames = [
  GameModel(
    id: 1,
    title: 'Catan',
    category: 'Estrategia',
    image: 'https://www.mosca.com.uy/media/catalog/product/4/8/4852725-1_1.jpg?height=700&width=700',
    rating: 4.8,
    reviews: 156,
    description:
        'Un juego clásico de construcción y comercio donde los jugadores compiten por recursos en una isla. Perfecto para noches de estrategia familiar.',
    duration: '60-90 min',
    players: '2-4 jugadores',
    difficulty: 'Medio',
    price: 45,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-04', to: '2025-11-12'),
      const AvailabilityRangeModel(from: '2025-11-20', to: '2025-11-30'),
      const AvailabilityRangeModel(from: '2025-12-10', to: '2025-12-20'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed?listType=search&list=c%C3%B3mo+jugar+Catan',
      text:
          'Cada turno, los jugadores colocan asentamientos y carreteras, comercian recursos y construyen ciudades. El primer jugador en alcanzar 10 puntos gana.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Raúl',
        role: 'Experimentado',
        rating: 5,
        comment: 'Increíble juego de estrategia. Nunca se vuelve aburrido con las diferentes combinaciones de tablero.',
      ),
      const GameReviewModel(
        name: 'María',
        role: 'Casual',
        rating: 4,
        comment: 'Muy divertido, aunque a veces los turnos son largos. Las reglas son fáciles de aprender.',
      ),
    ],
  ),
  GameModel(
    id: 2,
    title: 'Ticket to Ride',
    category: 'Estrategia',
    image: 'https://image.cdn1.buscalibre.com/529b8e15b896ab3b4d001c69.RS500x500.jpg',
    rating: 4.6,
    reviews: 203,
    description:
        'Conecta ciudades americanas construyendo rutas de ferrocarril. Un juego accesible pero estratégicamente profundo.',
    duration: '45-60 min',
    players: '2-5 jugadores',
    difficulty: 'Fácil',
    price: 50,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-08', to: '2025-11-15'),
      const AvailabilityRangeModel(from: '2025-11-24', to: '2025-12-02'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/GcwS4XdbjOk',
      text:
          'Los jugadores dibujan cartas de ruta y usan tarjetas de color para reivindicar rutas entre ciudades. Gana quien completa las rutas más valiosas.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Carlos',
        role: 'Aficionado',
        rating: 5,
        comment: '¡Espectacular! El tema de los ferrocarriles está bien implementado.',
      ),
    ],
  ),
  GameModel(
    id: 3,
    title: 'Pandemic',
    category: 'Cooperativo',
    image: 'https://http2.mlstatic.com/D_NQ_NP_2X_674534-MLU71367656852_082023-F.webp',
    rating: 4.7,
    reviews: 189,
    description:
        'Un emocionante juego cooperativo donde todos los jugadores trabajan juntos para evitar que enfermedades devasten el mundo.',
    duration: '45-60 min',
    players: '2-4 jugadores',
    difficulty: 'Medio',
    price: 48,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-05', to: '2025-11-14'),
      const AvailabilityRangeModel(from: '2025-11-28', to: '2025-12-05'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/C1M-87Xjr5o',
      text:
          'Los jugadores colaboran para encontrar curas de enfermedades antes de que se propaguen. Todos ganan o pierden juntos.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Andrea',
        role: 'Entusiasta',
        rating: 5,
        comment: 'Perfecto para jugar en grupo. La tensión es increíble.',
      ),
    ],
  ),
  GameModel(
    id: 4,
    title: 'Carcassonne',
    category: 'Estrategia',
    image:
        'https://f.fcdn.app/imgs/b67574/www.losreyesmagos.com.uy/reymuy/2550/original/catalogo/22323_22323_1/2000-2000/carcassonne-juego-de-mesa-carcassonne-juego-de-mesa.jpg',
    rating: 4.5,
    reviews: 142,
    description:
        'Construye un paisaje medieval colocando fichas. Un juego elegante con reglas simples pero profundidad táctica.',
    duration: '30-45 min',
    players: '2-5 jugadores',
    difficulty: 'Fácil',
    price: 35,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-10', to: '2025-11-18'),
      const AvailabilityRangeModel(from: '2025-12-01', to: '2025-12-10'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/zIeyB3ykf1s',
      text:
          'Cada turno coloca una ficha en el tablero formando ciudades, caminos y monasterios. Los puntos se ganan por completar formaciones.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Pablo',
        role: 'Casual',
        rating: 4,
        comment: 'Muy accesible y entretenido. Ideal para principiantes.',
      ),
    ],
  ),
  GameModel(
    id: 5,
    title: 'Splendor',
    category: 'Estrategia',
    image: 'https://http2.mlstatic.com/D_NQ_NP_2X_942518-MLA96179657775_102025-F.webp',
    rating: 4.6,
    reviews: 178,
    description: 'Sé un mercader de gemas renacentista. Un juego de motor de combos elegante y rápido.',
    duration: '30-45 min',
    players: '2-4 jugadores',
    difficulty: 'Fácil',
    price: 40,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-07', to: '2025-11-16'),
      const AvailabilityRangeModel(from: '2025-11-25', to: '2025-12-03'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/5enAMA8zq3E',
      text:
          'Colecciona gemas y compra desarrollos para aumentar tu motor de producción. El primer jugador en alcanzar 15 puntos gana.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Elena',
        role: 'Experimentada',
        rating: 5,
        comment: 'Mecanísticas hermosas y muy balanceado. Una joya.',
      ),
    ],
  ),
  GameModel(
    id: 6,
    title: 'Azul',
    category: 'Estrategia',
    image: 'https://upload.wikimedia.org/wikipedia/en/2/23/Picture_of_Azul_game_box.jpg',
    rating: 4.7,
    reviews: 167,
    description:
        'Un juego de colocación de fichas abstracto con una estética deslumbrante inspirada en azulejos portugueses.',
    duration: '30-45 min',
    players: '2-4 jugadores',
    difficulty: 'Fácil',
    price: 38,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-03', to: '2025-11-11'),
      const AvailabilityRangeModel(from: '2025-11-19', to: '2025-11-26'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/qhfPNSNRJZ0',
      text:
          'Toma fichas de azulejos del centro y colócalas en tu tablero. Completa filas para obtener puntos. El juego es puro, elegante y estratégico.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Sofia',
        role: 'Aficionada',
        rating: 5,
        comment: 'Bellísimo y muy divertido. Perfecto para dos jugadores.',
      ),
    ],
  ),
  GameModel(
    id: 7,
    title: 'Codenames',
    category: 'Fiesta',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Codenames_board_game.jpg/1200px-Codenames_board_game.jpg',
    rating: 4.6,
    reviews: 512,
    description:
        'Espías rivales compiten por contactar a su equipo mediante pistas ingeniosas. Es un party game rápido que genera risas, deducción y momentos épicos en cada turno.',
    duration: '15-20 min',
    players: '4-8 jugadores',
    difficulty: 'Fácil',
    price: 32,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-12', to: '2025-11-20'),
      const AvailabilityRangeModel(from: '2025-12-05', to: '2025-12-12'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/YhMBBnMHw_g',
      text:
          'Divide la mesa en dos equipos y nombra a un jefe que solo conoce el mapa secreto. En tu turno dices una palabra clave y un número para guiar a tus agentes hacia las cartas correctas.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Lucía',
        role: 'Casual',
        rating: 5,
        comment:
            'Siempre termina en carcajadas, incluso con gente que no juega mucho. Las pistas creativas hacen que cada partida sea distinta.',
      ),
      const GameReviewModel(
        name: 'Ernesto',
        role: 'Jugón',
        rating: 4,
        comment:
            'Como party es brillante, pero necesita grupos grandes para lucirse. A dos jugadores se siente forzado.',
      ),
    ],
  ),
  GameModel(
    id: 8,
    title: 'Dixit',
    category: 'Fiesta',
    image: 'https://upload.wikimedia.org/wikipedia/en/7/7b/Dixitgame.jpg',
    rating: 4.5,
    reviews: 284,
    description:
        'Cartas oníricas invitan a contar historias y leer entre líneas lo que piensan tus amigos. Es perfecto para grupos creativos que buscan momentos emotivos y risas cómplices.',
    duration: '30-40 min',
    players: '3-6 jugadores',
    difficulty: 'Fácil',
    price: 37,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-06', to: '2025-11-13'),
      const AvailabilityRangeModel(from: '2025-11-29', to: '2025-12-06'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/COSMzT6QSp0',
      text:
          'En cada ronda un narrador elige una carta y da una pista sutil sobre ella. El resto selecciona cartas de su mano que encajen con la pista y luego todos votan cuál creen que era la original.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Renata',
        role: 'Creativa',
        rating: 5,
        comment:
            'Las ilustraciones son hermosas y disparan conversaciones larguísimas. Es el favorito de mi grupo de arte.',
      ),
    ],
  ),
  GameModel(
    id: 9,
    title: 'Sushi Go!',
    category: 'Familiar',
    image:
        'https://cf.geekdo-images.com/Fn3PSPZVxa3YurlorITQ1Q__itemrep/img/XEFhq_xryUgTUJpNGF4tQH_5WRs=/fit-in/246x300/filters:strip_icc()/pic1900075.jpg',
    rating: 4.4,
    reviews: 198,
    description:
        'Un draft frenético de cartas donde preparas el menú perfecto de sushi. Ligero, adorable y con la dosis justa de decisiones tácticas.',
    duration: '15-20 min',
    players: '2-5 jugadores',
    difficulty: 'Fácil',
    price: 28,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-04', to: '2025-11-09'),
      const AvailabilityRangeModel(from: '2025-11-15', to: '2025-11-22'),
      const AvailabilityRangeModel(from: '2025-12-03', to: '2025-12-09'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/mYxE6SIBXGU',
      text:
          'Cada ronda eliges una carta de tu mano y pasas el resto al jugador vecino. Se puntúan los sets completados al final de la ronda y tras tres rondas gana quien tenga más puntos.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Diego',
        role: 'Casual',
        rating: 5,
        comment: 'La velocidad de cada turno mantiene a todos atentos. Es el filler ideal entre juegos largos.',
      ),
    ],
  ),
  GameModel(
    id: 10,
    title: 'Kingdomino',
    category: 'Familiar',
    image:
        'https://cf.geekdo-images.com/6jvhqNHdFTTe_OkYrqJdEg__itemheader/img/FkjHoGPOFO4-rqweD0WY4Kl6ZOo=/800x450/filters:quality(30):strip_icc()/pic3327248.jpg',
    rating: 4.3,
    reviews: 167,
    description:
        'Construye un diminuto reino de terrenos conectados con piezas tipo dominó. Es ágil, colorido y competitivo sin dejar de ser familiar.',
    duration: '20-25 min',
    players: '2-4 jugadores',
    difficulty: 'Fácil',
    price: 34,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-09', to: '2025-11-17'),
      const AvailabilityRangeModel(from: '2025-11-27', to: '2025-12-04'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/qhbEn6ax-Lc',
      text:
          'Cada ronda ordenas las losetas según su valor y eliges una para añadirla a tu cuadrícula 5x5 respetando los tipos de terreno.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Camila',
        role: 'Familiar',
        rating: 5,
        comment:
            'Funciona perfecto con peques, pero los adultos también peleamos cada punto. La variante 7x7 es un desafío.',
      ),
    ],
  ),
  GameModel(
    id: 11,
    title: 'Wingspan',
    category: 'Estrategia',
    image:
        'https://cf.geekdo-images.com/yLZJCVLlIx4c7eJEWUNJ7w__itemrep/img/DR7181wU4sHT6gn6Q1XccpPxNHg=/fit-in/246x300/filters:strip_icc()/pic4458123.jpg',
    rating: 4.7,
    reviews: 982,
    description:
        'Gestiona un santuario de aves construyendo combos entre hábitats y poderes únicos. Destaca por su producción de lujo y una experiencia relajada pero estratégica.',
    duration: '70-90 min',
    players: '1-5 jugadores',
    difficulty: 'Medio',
    price: 58,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-18', to: '2025-11-28'),
      const AvailabilityRangeModel(from: '2025-12-10', to: '2025-12-20'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/chK4VV4UMBs',
      text:
          'En tu turno eliges una de cuatro acciones: jugar un ave, conseguir comida, poner huevos o robar cartas. Cada ave añade habilidades que se encadenan de izquierda a derecha en el hábitat correspondiente.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Florencia',
        role: 'Entusiasta',
        rating: 5,
        comment: 'El motor de combos es adictivo y la producción enamora a quien se siente a la mesa.',
      ),
    ],
  ),
  GameModel(
    id: 12,
    title: 'Terraforming Mars',
    category: 'Experto',
    image:
        'https://cf.geekdo-images.com/wg9oOLcsKvDesSUdZQ4rxw__itemrep/img/IwUOQfhP5c0KcRJBY4X_hi3LpsY=/fit-in/246x300/filters:strip_icc()/pic3536616.jpg',
    rating: 4.8,
    reviews: 1104,
    description:
        'Corporaciones rivales colaboran y compiten por hacer habitable el planeta rojo. Un eurogame profundo con cientos de cartas y caminos estratégicos.',
    duration: '120-150 min',
    players: '1-5 jugadores',
    difficulty: 'Difícil',
    price: 65,
    availability: [
      const AvailabilityRangeModel(from: '2025-11-21', to: '2025-12-01'),
      const AvailabilityRangeModel(from: '2025-12-15', to: '2025-12-26'),
    ],
    rules: const GameRulesModel(
      video: 'https://www.youtube-nocookie.com/embed/wTsVrcuTdso',
      text:
          'Cada generación juegas proyectos, produces recursos y subes temperatura, oxígeno y océanos. Las cartas otorgan efectos inmediatos, permanentes o acciones que moldean tu motor económico.',
    ),
    reviewsList: [
      const GameReviewModel(
        name: 'Santiago',
        role: 'Jugón',
        rating: 5,
        comment:
            'Una experiencia épica que no me aburre tras decenas de partidas. Las corporaciones asimétricas cambian totalmente el plan.',
      ),
    ],
  ),
];
