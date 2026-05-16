import 'package:demo_app/generated/app_localizations.dart';

enum PetType {
  dog,
  cat,
  bird,
  rabbit,
  hamster,
  guineaPig,
  fish,
  turtle,
  snake,
  lizard,
  hedgehog,
  ferret,
  rat,
  frog,
  other,
}

extension PetTypeX on PetType {
  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case PetType.dog:
        return l10n.dog;
      case PetType.cat:
        return l10n.cat;
      case PetType.bird:
        return l10n.bird;
      case PetType.rabbit:
        return l10n.rabbit;
      case PetType.hamster:
        return l10n.hamster;
      case PetType.guineaPig:
        return l10n.guineaPig;
      case PetType.fish:
        return l10n.fish;
      case PetType.turtle:
        return l10n.turtle;
      case PetType.snake:
        return l10n.snake;
      case PetType.lizard:
        return l10n.lizard;
      case PetType.hedgehog:
        return l10n.hedgehog;
      case PetType.ferret:
        return l10n.ferret;
      case PetType.rat:
        return l10n.rat;
      case PetType.frog:
        return l10n.frog;
      case PetType.other:
        return l10n.other;
    }
  }
}

// final l10n = AppLocalizations.of(context);
enum PetBreed {
  // ── Dog (Chó) ────────────────────────────────────────────────────────────
  germanShepherd(PetType.dog, 'Béc-giê Đức'),
  goldenRetriever(PetType.dog, 'Golden Retriever'),
  bulldog(PetType.dog, 'Bulldog'),
  beagle(PetType.dog, 'Beagle'),
  poodle(PetType.dog, 'Poodle'),
  labradorRetriever(PetType.dog, 'Labrador Retriever'),
  chihuahua(PetType.dog, 'Chihuahua'),
  shibaInu(PetType.dog, 'Shiba Inu'),
  corgi(PetType.dog, 'Corgi'),
  husky(PetType.dog, 'Husky'),

  // ── Cat (Mèo) ────────────────────────────────────────────────────────────
  siamese(PetType.cat, 'Mèo Xiêm'),
  persian(PetType.cat, 'Mèo Ba Tư'),
  britishShorthair(PetType.cat, 'Mèo Anh lông ngắn'),
  bengal(PetType.cat, 'Mèo Bengal'),
  ragdoll(PetType.cat, 'Mèo Ragdoll'),
  maineCoon(PetType.cat, 'Mèo Maine Coon'),
  scottishFold(PetType.cat, 'Mèo Scottish Fold'),

  // ── Bird (Chim) ──────────────────────────────────────────────────────────
  parrot(PetType.bird, 'Vẹt'),
  canary(PetType.bird, 'Chim Canary'),
  finch(PetType.bird, 'Chim Sẻ'),
  cockatiel(PetType.bird, 'Vẹt Cockatiel'),
  lovebird(PetType.bird, 'Chim Tình Yêu'),
  budgerigar(PetType.bird, 'Vẹt Úc'),
  macaw(PetType.bird, 'Vẹt Macaw'),

  // ── Rabbit (Thỏ) ─────────────────────────────────────────────────────────
  hollandLop(PetType.rabbit, 'Holland Lop'),
  netherlandDwarf(PetType.rabbit, 'Thỏ lùn Hà Lan'),
  lionhead(PetType.rabbit, 'Thỏ đầu sư tử'),
  rexRabbit(PetType.rabbit, 'Thỏ Rex'),
  angora(PetType.rabbit, 'Thỏ Angora'),
  miniRex(PetType.rabbit, 'Mini Rex'),

  // ── Hamster ──────────────────────────────────────────────────────────────
  syrianHamster(PetType.hamster, 'Hamster Syrian'),
  campbellHamster(PetType.hamster, 'Hamster Campbell'),
  roborovskiHamster(PetType.hamster, 'Hamster Roborovski'),
  chineseHamster(PetType.hamster, 'Hamster Trung Quốc'),
  winterWhiteHamster(PetType.hamster, 'Hamster Winter White'),

  // ── Guinea Pig (Chuột lang) ───────────────────────────────────────────────
  americanGuineaPig(PetType.guineaPig, 'Chuột lang Mỹ'),
  peruGuineaPig(PetType.guineaPig, 'Chuột lang Peru'),
  abbyssinianGuineaPig(PetType.guineaPig, 'Chuột lang Abyssinian'),
  teddyGuineaPig(PetType.guineaPig, 'Chuột lang Teddy'),
  texelGuineaPig(PetType.guineaPig, 'Chuột lang Texel'),

  // ── Fish (Cá) ────────────────────────────────────────────────────────────
  bettaFish(PetType.fish, 'Cá Betta'),
  goldfish(PetType.fish, 'Cá Vàng'),
  guppy(PetType.fish, 'Cá Guppy'),
  koi(PetType.fish, 'Cá Koi'),
  molly(PetType.fish, 'Cá Molly'),
  angelfish(PetType.fish, 'Cá Thiên thần'),
  clownfish(PetType.fish, 'Cá Hề'),

  // ── Turtle (Rùa) ─────────────────────────────────────────────────────────
  redEaredSlider(PetType.turtle, 'Rùa tai đỏ'),
  boxTurtle(PetType.turtle, 'Rùa hộp'),
  russianTortoise(PetType.turtle, 'Rùa Nga'),
  paintedTurtle(PetType.turtle, 'Rùa sơn'),
  greekTortoise(PetType.turtle, 'Rùa Hy Lạp'),

  // ── Snake (Rắn) ──────────────────────────────────────────────────────────
  ballPython(PetType.snake, 'Trăn cầu'),
  cornSnake(PetType.snake, 'Rắn ngô'),
  kingSnake(PetType.snake, 'Rắn vua'),
  milkSnake(PetType.snake, 'Rắn sữa'),
  hognoseSnake(PetType.snake, 'Rắn mũi hếch'),

  // ── Lizard (Thằn lằn) ────────────────────────────────────────────────────
  beardedDragon(PetType.lizard, 'Rồng râu'),
  leopardGecko(PetType.lizard, 'Tắc kè báo'),
  blueTonguedSkink(PetType.lizard, 'Thằn lằn lưỡi xanh'),
  cresstedGecko(PetType.lizard, 'Tắc kè mào'),
  chameleon(PetType.lizard, 'Tắc kè hoa'),

  // ── Hedgehog (Nhím) ──────────────────────────────────────────────────────
  africanPygmyHedgehog(PetType.hedgehog, 'Nhím lùn châu Phi'),
  europeanHedgehog(PetType.hedgehog, 'Nhím châu Âu'),
  egyptianLongEaredHedgehog(PetType.hedgehog, 'Nhím tai dài Ai Cập'),
  somalianHedgehog(PetType.hedgehog, 'Nhím Somalia'),
  indianLongEaredHedgehog(PetType.hedgehog, 'Nhím tai dài Ấn Độ'),

  // ── Ferret (Chồn) ────────────────────────────────────────────────────────
  sableFerret(PetType.ferret, 'Chồn Sable'),
  albinFerret(PetType.ferret, 'Chồn Albino'),
  silverMittFerret(PetType.ferret, 'Chồn Silver Mitt'),
  pandaFerret(PetType.ferret, 'Chồn Panda'),
  chocolateFerret(PetType.ferret, 'Chồn Chocolate'),

  // ── Rat (Chuột) ──────────────────────────────────────────────────────────
  fancyRat(PetType.rat, 'Chuột Fancy'),
  dumboBrat(PetType.rat, 'Chuột Dumbo'),
  rexRat(PetType.rat, 'Chuột Rex'),
  hairlessRat(PetType.rat, 'Chuột không lông'),
  satinaRat(PetType.rat, 'Chuột Satin'),

  // ── Frog (Ếch) ───────────────────────────────────────────────────────────
  pacmanFrog(PetType.frog, 'Ếch Pac-Man'),
  dumpyTreeFrog(PetType.frog, 'Ếch cây Dumpy'),
  africanDwarfFrog(PetType.frog, 'Ếch lùn châu Phi'),
  tomatoFrog(PetType.frog, 'Ếch cà chua'),
  firebellyToad(PetType.frog, 'Cóc bụng lửa'),

  // ── Other (Khác) ─────────────────────────────────────────────────────────
  other(PetType.other, 'Khác');

  /// Loại thú cưng tương ứng
  final PetType type;

  /// Tên hiển thị
  final String displayName;

  const PetBreed(this.type, this.displayName);

  /// Lấy tên hiển thị đã đa ngôn ngữ hóa
  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case PetBreed.germanShepherd:
        return l10n.germanShepherd;
      case PetBreed.goldenRetriever:
        return l10n.goldenRetriever;
      case PetBreed.bulldog:
        return l10n.bulldog;
      case PetBreed.beagle:
        return l10n.beagle;
      case PetBreed.poodle:
        return l10n.poodle;
      case PetBreed.labradorRetriever:
        return l10n.labradorRetriever;
      case PetBreed.chihuahua:
        return l10n.chihuahua;
      case PetBreed.shibaInu:
        return l10n.shibaInu;
      case PetBreed.corgi:
        return l10n.corgi;
      case PetBreed.husky:
        return l10n.husky;
      case PetBreed.siamese:
        return l10n.siamese;
      case PetBreed.persian:
        return l10n.persian;
      case PetBreed.britishShorthair:
        return l10n.britishShorthair;
      case PetBreed.bengal:
        return l10n.bengal;
      case PetBreed.ragdoll:
        return l10n.ragdoll;
      case PetBreed.maineCoon:
        return l10n.maineCoon;
      case PetBreed.scottishFold:
        return l10n.scottishFold;
      case PetBreed.parrot:
        return l10n.parrot;
      case PetBreed.canary:
        return l10n.canary;
      case PetBreed.finch:
        return l10n.finch;
      case PetBreed.cockatiel:
        return l10n.cockatiel;
      case PetBreed.lovebird:
        return l10n.lovebird;
      case PetBreed.budgerigar:
        return l10n.budgerigar;
      case PetBreed.macaw:
        return l10n.macaw;
      case PetBreed.hollandLop:
        return l10n.hollandLop;
      case PetBreed.netherlandDwarf:
        return l10n.netherlandDwarf;
      case PetBreed.lionhead:
        return l10n.lionhead;
      case PetBreed.rexRabbit:
        return l10n.rexRabbit;
      case PetBreed.angora:
        return l10n.angora;
      case PetBreed.miniRex:
        return l10n.miniRex;
      case PetBreed.syrianHamster:
        return l10n.syrianHamster;
      case PetBreed.campbellHamster:
        return l10n.campbellHamster;
      case PetBreed.roborovskiHamster:
        return l10n.roborovskiHamster;
      case PetBreed.chineseHamster:
        return l10n.chineseHamster;
      case PetBreed.winterWhiteHamster:
        return l10n.winterWhiteHamster;
      case PetBreed.americanGuineaPig:
        return l10n.americanGuineaPig;
      case PetBreed.peruGuineaPig:
        return l10n.peruGuineaPig;
      case PetBreed.abbyssinianGuineaPig:
        return l10n.abbyssinianGuineaPig;
      case PetBreed.teddyGuineaPig:
        return l10n.teddyGuineaPig;
      case PetBreed.texelGuineaPig:
        return l10n.texelGuineaPig;
      case PetBreed.bettaFish:
        return l10n.bettaFish;
      case PetBreed.goldfish:
        return l10n.goldfish;
      case PetBreed.guppy:
        return l10n.guppy;
      case PetBreed.koi:
        return l10n.koi;
      case PetBreed.molly:
        return l10n.molly;
      case PetBreed.angelfish:
        return l10n.angelfish;
      case PetBreed.clownfish:
        return l10n.clownfish;
      case PetBreed.redEaredSlider:
        return l10n.redEaredSlider;
      case PetBreed.boxTurtle:
        return l10n.boxTurtle;
      case PetBreed.russianTortoise:
        return l10n.russianTortoise;
      case PetBreed.paintedTurtle:
        return l10n.paintedTurtle;
      case PetBreed.greekTortoise:
        return l10n.greekTortoise;
      case PetBreed.ballPython:
        return l10n.ballPython;
      case PetBreed.cornSnake:
        return l10n.cornSnake;
      case PetBreed.kingSnake:
        return l10n.kingSnake;
      case PetBreed.milkSnake:
        return l10n.milkSnake;
      case PetBreed.hognoseSnake:
        return l10n.hognoseSnake;
      case PetBreed.beardedDragon:
        return l10n.beardedDragon;
      case PetBreed.leopardGecko:
        return l10n.leopardGecko;
      case PetBreed.blueTonguedSkink:
        return l10n.blueTonguedSkink;
      case PetBreed.cresstedGecko:
        return l10n.cresstedGecko;
      case PetBreed.chameleon:
        return l10n.chameleon;
      case PetBreed.africanPygmyHedgehog:
        return l10n.africanPygmyHedgehog;
      case PetBreed.europeanHedgehog:
        return l10n.europeanHedgehog;
      case PetBreed.egyptianLongEaredHedgehog:
        return l10n.egyptianLongEaredHedgehog;
      case PetBreed.somalianHedgehog:
        return l10n.somalianHedgehog;
      case PetBreed.indianLongEaredHedgehog:
        return l10n.indianLongEaredHedgehog;
      case PetBreed.sableFerret:
        return l10n.sableFerret;
      case PetBreed.albinFerret:
        return l10n.albinFerret;
      case PetBreed.silverMittFerret:
        return l10n.silverMittFerret;
      case PetBreed.pandaFerret:
        return l10n.pandaFerret;
      case PetBreed.chocolateFerret:
        return l10n.chocolateFerret;
      case PetBreed.fancyRat:
        return l10n.fancyRat;
      case PetBreed.dumboBrat:
        return l10n.dumboBrat;
      case PetBreed.rexRat:
        return l10n.rexRat;
      case PetBreed.hairlessRat:
        return l10n.hairlessRat;
      case PetBreed.satinaRat:
        return l10n.satinaRat;
      case PetBreed.pacmanFrog:
        return l10n.pacmanFrog;
      case PetBreed.dumpyTreeFrog:
        return l10n.dumpyTreeFrog;
      case PetBreed.africanDwarfFrog:
        return l10n.africanDwarfFrog;
      case PetBreed.tomatoFrog:
        return l10n.tomatoFrog;
      case PetBreed.firebellyToad:
        return l10n.firebellyToad;
      case PetBreed.other:
        return l10n.other;
      default:
        return displayName;
    }
  }

  /// Lấy tất cả giống loài thuộc một loại cụ thể
  static List<PetBreed> getBreedsByType(PetType type) {
    return PetBreed.values.where((b) => b.type == type).toList();
  }

  /// Parse từ string (tên enum)
  static PetBreed? fromName(String? name) {
    if (name == null) return null;
    try {
      return PetBreed.values.firstWhere((b) => b.name == name);
    } catch (_) {
      return null;
    }
  }
}

enum PetGender { male, female, unknown }

class Pet {
  final String id;
  final String name; // tên thú cưng
  final PetType type; // loại thú cưng
  final PetBreed? breed; // giống
  final PetGender gender; // giới tính
  final double? weight; // cân nặng
  final DateTime? birthday; // ngày sinh
  final String? color; // màu sắc
  final String? avatarPath; // đường dẫn ảnh đại diện
  final DateTime? createdAt; // ngày tạo
  final DateTime? updatedAt; // ngày cập nhật

  Pet({
    required this.id,
    required this.name,
    required this.type,
    this.breed,
    this.gender = PetGender.unknown,
    this.weight,
    this.birthday,
    this.color,
    this.avatarPath,
    this.createdAt,
    this.updatedAt,
  });

  // ================= JSON =================

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      type: _parseType(json['type']),
      breed: PetBreed.fromName(json['breed']?.toString()),
      gender: _parseGender(json['gender']),
      weight: _parseDouble(json['weight']),
      birthday: _parseDate(json['birthday']),
      color: json['color']?.toString(),
      avatarPath: json['avatar_url']?.toString(),
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'breed': breed?.name,
      'gender': gender.name,
      'weight': weight,
      'birthday': birthday?.toIso8601String(),
      'color': color,
      'avatar_url': avatarPath,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // ================= HELPERS =================

  static PetType _parseType(dynamic value) {
    final v = value?.toString().toLowerCase();
    try {
      return PetType.values.firstWhere((t) => t.name == v);
    } catch (_) {
      return PetType.other;
    }
  }

  static PetGender _parseGender(dynamic value) {
    switch (value?.toString().toLowerCase()) {
      case 'male':
        return PetGender.male;
      case 'female':
        return PetGender.female;
      default:
        return PetGender.unknown;
    }
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  // ================= COPY =================

  Pet copyWith({
    String? name,
    PetType? type,
    PetBreed? breed,
    PetGender? gender,
    double? weight,
    DateTime? birthday,
    String? color,
    String? avatarPath,
  }) {
    return Pet(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      breed: breed ?? this.breed,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      birthday: birthday ?? this.birthday,
      color: color ?? this.color,
      avatarPath: avatarPath ?? this.avatarPath,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
