import 'package:brewly/domain/entities/cafe.dart';
import 'package:brewly/domain/entities/country_coffee.dart';
import 'package:brewly/domain/repositories/explore_tab_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExploreTabRepo)
class ExploreTabRepoImpl implements ExploreTabRepo {
  final List<CountryCoffee> countries = [
    CountryCoffee(
      name: 'Ethiopia',
      flag: 'assets/images/flags/ethiopia.jpg',
      famousCoffees: ['Yirgacheffe', 'Sidamo', 'Harrar'],
      intensity: 'Medium to Light',
      flavorProfile: 'Floral, citrus, bright acidity, tea-like notes',
      cafes: [
        Cafe(name: 'Tomoca Coffee', link: 'https://tomocacoffee.com'),
        Cafe(name: 'Kaldi’s Coffee', link: 'https://kaldiscoffeeethiopia.com'),
        Cafe(name: 'Garden of Coffee', link: 'https://gardenofcoffee.com'),
      ],
    ),

    CountryCoffee(
      name: 'Colombia',
      flag: 'assets/images/flags/colombia.jpg',
      famousCoffees: ['Supremo', 'Excelso', 'Huila'],
      intensity: 'Medium',
      flavorProfile: 'Nutty, caramel notes, smooth and balanced',
      cafes: [
        Cafe(name: 'Juan Valdez Café', link: 'https://juanvaldezcafe.com'),
        Cafe(name: 'Devoción', link: 'https://devocion.com'),
        Cafe(name: 'Pergamino Café', link: 'https://pergamino.co'),
      ],
    ),

    CountryCoffee(
      name: 'Brazil',
      flag: 'assets/images/flags/brazil.jpg',
      famousCoffees: ['Santos', 'Bourbon', 'Catuai'],
      intensity: 'Medium to Dark',
      flavorProfile: 'Chocolatey, nutty, low acidity',
      cafes: [
        Cafe(name: 'Cafe Paulista', link: 'https://cafepaulista.com.br'),
        Cafe(name: 'Octavio Café', link: 'https://octaviocafe.com'),
        Cafe(name: 'Coffee Lab', link: 'https://coffeelab.com.br'),
      ],
    ),

    CountryCoffee(
      name: 'Kenya',
      flag: 'assets/images/flags/kenya.jpg',
      famousCoffees: ['Kenya AA', 'Peaberry'],
      intensity: 'Medium',
      flavorProfile: 'Berry notes, bright acidity, wine-like flavor',
      cafes: [
        Cafe(name: 'Java House Kenya', link: 'https://javahouseafrica.com'),
        Cafe(name: 'Artcaffé', link: 'https://artcaffe.co.ke'),
      ],
    ),

    CountryCoffee(
      name: 'Guatemala',
      flag: 'assets/images/flags/guatemala.jpg',
      famousCoffees: ['Antigua', 'Huehuetenango', 'Cobán'],
      intensity: 'Medium to High',
      flavorProfile: 'Spicy, chocolatey, full-bodied',
      cafes: [
        Cafe(name: 'El Injerto Café', link: 'https://fincainjerto.com'),
        Cafe(name: 'Cafe LAGUNA', link: ''),
        Cafe(name: 'Cafe Boheme', link: ''),
      ],
    ),

    CountryCoffee(
      name: 'Yemen',
      flag: 'assets/images/flags/yemen.jpg',
      famousCoffees: ['Yemen Mocha', 'Sana\'ani', 'Harazi'],
      intensity: 'High',
      flavorProfile: 'Deep chocolate notes, dried fruit, earthy, wine-like',
      cafes: [
        Cafe(name: 'Al Mokha Coffee', link: 'https://almokhaco.com'),
        Cafe(name: 'Mocha Hunters', link: 'https://mochahunters.com'),
      ],
    ),

    CountryCoffee(
      name: 'Egypt',
      flag: 'assets/images/flags/egypt.jpg',
      famousCoffees: [
        'Arabic Coffee (Ahwa Arabi)',
        'Turkish Coffee',
        'Imported Ethiopian/Yemeni blends',
      ],
      intensity: 'Medium to Dark',
      flavorProfile: 'Bold, slightly bitter, rich, sometimes cardamom',
      cafes: [
        Cafe(name: 'Cilantro', link: 'https://www.cilantrocafe.net'),
        Cafe(name: '30 North Coffee', link: 'https://30north.com'),
        Cafe(name: 'Brown Nose Coffee', link: 'https://brownnosecoffee.com'),
        Cafe(name: 'Starbucks Egypt', link: 'https://starbucks.com.eg'),
        Cafe(name: 'Costa Coffee Egypt', link: 'https://costa.eg'),
      ],
    ),

    CountryCoffee(
      name: 'Costa Rica',
      flag: 'assets/images/flags/costarica.jpg',
      famousCoffees: ['Tarrazu', 'Brunca'],
      intensity: 'Medium',
      flavorProfile: 'Bright acidity, clean, citrus and honey notes',
      cafes: [
        Cafe(name: 'Cafe Britt', link: 'https://cafebritt.com'),
        Cafe(name: 'La Mancha Coffee', link: ''),
      ],
    ),

    CountryCoffee(
      name: 'Peru',
      flag: 'assets/images/flags/peru.jpg',
      famousCoffees: ['Chanchamayo', 'Cusco'],
      intensity: 'Medium',
      flavorProfile: 'Mild acidity, nutty, chocolatey',
      cafes: [
        Cafe(name: 'Tostaduria Bisetti', link: 'https://bisetti.com'),
        Cafe(name: 'Puku Puku', link: ''),
      ],
    ),

    CountryCoffee(
      name: 'Honduras',
      flag: 'assets/images/flags/honduras.jpg',
      famousCoffees: ['Copán', 'Marcala'],
      intensity: 'Medium to High',
      flavorProfile: 'Sweet, chocolatey, fruity acidity',
      cafes: [Cafe(name: 'Cafe San Rafael', link: '')],
    ),

    CountryCoffee(
      name: 'Tanzania',
      flag: 'assets/images/flags/tanzania.jpg',
      famousCoffees: ['Kilimanjaro', 'Peaberry'],
      intensity: 'Medium',
      flavorProfile: 'Berry-like, bright acidity, rich body',
      cafes: [Cafe(name: 'Kilimanjaro Coffee', link: '')],
    ),

    CountryCoffee(
      name: 'Indonesia',
      flag: 'assets/images/flags/indonesia.jpg',
      famousCoffees: ['Sumatra', 'Java', 'Sulawesi'],
      intensity: 'Dark',
      flavorProfile: 'Earthy, herbal, low acidity',
      cafes: [
        Cafe(name: 'Tanamera Coffee', link: 'https://tanameracoffee.com'),
      ],
    ),

    CountryCoffee(
      name: 'Vietnam',
      flag: 'assets/images/flags/vietnam.jpg',
      famousCoffees: ['Robusta', 'Da Lat Arabica'],
      intensity: 'High',
      flavorProfile: 'Strong, bold, chocolatey, earthy',
      cafes: [
        Cafe(
          name: 'Trung Nguyen Legend',
          link: 'https://trungnguyenlegend.com',
        ),
      ],
    ),

    CountryCoffee(
      name: 'India',
      flag: 'assets/images/flags/india.jpg',
      famousCoffees: ['Monsooned Malabar', 'Coorg', 'Araku'],
      intensity: 'Medium to Dark',
      flavorProfile: 'Spicy, earthy, low acidity',
      cafes: [
        Cafe(name: 'Blue Tokai Coffee', link: 'https://bluetokaicoffee.com'),
      ],
    ),

    CountryCoffee(
      name: 'Panama',
      flag: 'assets/images/flags/panama.jpg',
      famousCoffees: ['Geisha', 'Boquete'],
      intensity: 'Light to Medium',
      flavorProfile: 'Floral, fruity, tea-like, very high quality',
      cafes: [Cafe(name: 'Kotowa Coffee', link: 'https://kotowa.com')],
    ),
  ];

  @override
  Future<List<CountryCoffee>> allCountriesCoffees() async {
    return countries;
  }
}
