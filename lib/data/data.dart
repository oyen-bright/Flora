import 'package:flutter/material.dart';
import 'package:flora/assets.dart';
import 'package:flora/models/models.dart';

class Item {
  String head;
  String description;
  String img;
  Color clr;
  Item({this.head, this.description, this.img, this.clr});
}

class ListofItems {
  static List<Item> loadlist() {
    var l = <Item>[
      Item(
          img: 'assets/images/blank.png',
          clr: Colors.black,
          head: 'Trying to join Netflix?',
          description:
              ' We know it\'s a hassle. After\n you\'re a member, you can start\n watching in this app.'),
      Item(
          img: 'assets/images/anydevice.png',
          clr: Colors.black,
          head: 'Watch on any device',
          description:
              'Stream on your phone, tablet,\n laptop, and TV without paying\n more.'),
      Item(
          img: 'assets/images/download.png',
          clr: Colors.black,
          head: '3,2,1... Download!',
          description: 'Always have something to\n watch offline.'),
      Item(
          img: 'assets/images/nocontract.png',
          clr: Colors.black,
          head: 'No pesky contracts',
          description: 'Cancel anytime.'),
      Item(
          img: 'assets/images/nocontract.png',
          clr: Colors.black,
          head: 'No pesky contracts',
          description: 'Cancel anytime.')
    ];
    return l;
  }
}

const List likesList = [
  {"icon": Icons.add, "text": "My List"},
  {"icon": Icons.send_outlined, "text": "Share"}
];
const List episodesList = ["MORE LIKE THIS"];

final Content sintelContent = Content(
  name: 'Sintel',
  imageUrl: Assets.sintel,
  titleImageUrl: Assets.sintelTitle,
  videoUrl: Assets.sintelVideoUrl,
  description:
      'A lonely young woman, Sintel, helps and befriends a dragon,\nwhom she calls Scales. But when he is kidnapped by an adult\ndragon, Sintel decides to embark on a dangerous quest to find\nher lost friend Scales.',
);
final List<Content> headerContent = const [
  Content(
    name: 'Sintel',
    imageUrl: 'Assets.sintel',
    titleImageUrl: Assets.sintelTitle,
    videoUrl: Assets.sintelVideoUrl,
    isTrending: false,
    price: '400',
    category: 'Action',
    description:
        'A lonely young woman, Sintel, helps and befriends a dragon,\nwhom she calls Scales. But when he is kidnapped by an adult\ndragon, Sintel decides to embark on a dangerous quest to find\nher lost friend Scales.',
  ),
  Content(
    name: 'Sintel',
    imageUrl: Assets.breakingBad,
    titleImageUrl: Assets.sintelTitle,
    videoUrl: Assets.sintelVideoUrl,
    price: '500',
    isTrending: true,
    category: 'Comedy',
    description:
        'A lonely young woman, Sintel, helps and befriends a dragon,\nwhom she calls Scales. But when he is kidnapped by an adult\ndragon, Sintel decides to embark on a dangerous quest to find\nher lost friend Scales.',
  ),
  Content(
    name: 'Sintel',
    imageUrl: Assets.blackMirror,
    titleImageUrl: Assets.sintelTitle,
    videoUrl: Assets.sintelVideoUrl,
    price: '300',
    category: 'Adventure',
    isTrending: false,
    description:
        'A lonely young woman, Sintel, helps and befriends a dragon,\nwhom she calls Scales. But when he is kidnapped by an adult\ndragon, Sintel decides to embark on a dangerous quest to find\nher lost friend Scales.',
  ),
];

final List<Content> previews = const [
  Content(
    name: 'Avatar The Last Airbender',
    imageUrl: Assets.atla,
    color: Colors.orange,
    titleImageUrl: Assets.atlaTitle,
  ),
  Content(
    name: 'The Crown',
    imageUrl: Assets.crown,
    color: Colors.red,
    titleImageUrl: Assets.crownTitle,
  ),
  Content(
    name: 'The Umbrella Academy',
    imageUrl: Assets.umbrellaAcademy,
    color: Colors.yellow,
    titleImageUrl: Assets.umbrellaAcademyTitle,
  ),
  Content(
    name: 'Carole and Tuesday',
    imageUrl: Assets.caroleAndTuesday,
    color: Colors.lightBlueAccent,
    titleImageUrl: Assets.caroleAndTuesdayTitle,
  ),
  Content(
    name: 'Black Mirror',
    imageUrl: Assets.blackMirror,
    color: Colors.green,
    titleImageUrl: Assets.blackMirrorTitle,
  ),
  Content(
    name: 'Avatar The Last Airbender',
    imageUrl: Assets.atla,
    color: Colors.orange,
    titleImageUrl: Assets.atlaTitle,
  ),
  Content(
    name: 'The Crown',
    imageUrl: Assets.crown,
    color: Colors.red,
    titleImageUrl: Assets.crownTitle,
  ),
  Content(
    name: 'The Umbrella Academy',
    imageUrl: Assets.umbrellaAcademy,
    color: Colors.yellow,
    titleImageUrl: Assets.umbrellaAcademyTitle,
  ),
  Content(
    name: 'Carole and Tuesday',
    imageUrl: Assets.caroleAndTuesday,
    color: Colors.lightBlueAccent,
    titleImageUrl: Assets.caroleAndTuesdayTitle,
  ),
  Content(
    name: 'Black Mirror',
    imageUrl: Assets.blackMirror,
    color: Colors.green,
    titleImageUrl: Assets.blackMirrorTitle,
  ),
];

final List<Content> myList = const [
  Content(
      name: 'Violet RRRRRRREvergarden',
      imageUrl: Assets.violetEvergarden,
      isTopMovie: true),
  Content(
      name: 'How to Sell Drugs Online (Fast)',
      imageUrl: Assets.htsdof,
      isTrending: true),
  Content(name: 'Kakegurui', imageUrl: Assets.kakegurui),
  Content(name: 'Carole and Tuesday', imageUrl: Assets.caroleAndTuesday),
  Content(name: 'Black Mirror', imageUrl: Assets.blackMirror),
  Content(name: 'Violet Evergarden', imageUrl: Assets.violetEvergarden),
  Content(name: 'How to Sell Drugs Online (Fast)', imageUrl: Assets.htsdof),
  Content(name: 'Kakegurui', imageUrl: Assets.kakegurui),
  Content(
      name: 'Carole and Tuesday',
      imageUrl: Assets.caroleAndTuesday,
      isTopMovie: true),
  Content(name: 'Black Mirror', imageUrl: Assets.blackMirror),
];

final List<Content> originals = const [
  Content(name: 'Stranger Things', imageUrl: Assets.strangerThings),
  Content(name: 'The Witcher', imageUrl: Assets.witcher),
  Content(name: 'The Umbrella Academy', imageUrl: Assets.umbrellaAcademy),
  Content(name: '13 Reasons Why', imageUrl: Assets.thirteenReasonsWhy),
  Content(name: 'The End of the F***ing World', imageUrl: Assets.teotfw),
  Content(name: 'Stranger Things', imageUrl: Assets.strangerThings),
  Content(name: 'The Witcher', imageUrl: Assets.witcher),
  Content(name: 'The Umbrella Academy', imageUrl: Assets.umbrellaAcademy),
  Content(name: '13 Reasons Why', imageUrl: Assets.thirteenReasonsWhy),
  Content(name: 'The End of the F***ing World', imageUrl: Assets.teotfw),
];

final List<Content> trending = const [
  Content(name: 'Explained', imageUrl: Assets.explained),
  Content(name: 'Avatar The Last Airbender', imageUrl: Assets.atla),
  Content(name: 'Tiger King', imageUrl: Assets.tigerKing),
  Content(name: 'The Crown', imageUrl: Assets.crown),
  Content(name: 'Dogs', imageUrl: Assets.dogs),
  Content(name: 'Explained', imageUrl: Assets.explained),
  Content(name: 'Avatar The Last Airbender', imageUrl: Assets.atla),
  Content(name: 'Tiger King', imageUrl: Assets.tigerKing),
  Content(name: 'The Crown', imageUrl: Assets.crown),
  Content(name: 'Dogs', imageUrl: Assets.dogs),
];

const List movieList = [
  {
    "img": "assets/images/detail_1.webp",
    "title": "1. The Rise of Nobunaga",
    "description":
        "Considered a fool and unfit to lead, Nobunaga rises to power as the head of the Oda clan, spurring dissent among those in his family vying for control.",
    "duration": "42m"
  },
  {
    "img": "assets/images/detail_2.webp",
    "title": "2. Seizing Power",
    "description":
        "Nobunaga angers warlords when he captures most of the central Japan and ignites a fierce war with Takeda Shingen, a formidable daimyo.",
    "duration": "42m"
  },
  {
    "img": "assets/images/detail_3.webp",
    "title": "3. The Demon King",
    "description":
        "As Nobunaga's ambitions intensify, some generals start to question his command, leading to a betrayal that alters the political landscape forever.",
    "duration": "42m"
  },
  {
    "img": "assets/images/detail_4.webp",
    "title": "4. Complete Control",
    "description":
        "Toyotomi Hideyoshi ascendes to power as the de facto ruler of Japan. Still, Date Masamune, a young daimyo in the north, ignores his missives.",
    "duration": "43m"
  },
  {
    "img": "assets/images/detail_5.webp",
    "title": "5. Catastrophe",
    "description":
        "With the country unified, Hideyoshi plans to expand his regn to China. Logistical chanllenges and fierce opposition in Korea prove to be costly.",
    "duration": "43m"
  },
  {
    "img": "assets/images/detail_6.webp",
    "title": "6. Birth of a Dynasty",
    "description":
        "a dying Hideyoshi appoints five agents to govern til his son comes of age, but the power-hungry Tokugawa leyasu declares war on those who oppose him.",
    "duration": "44m"
  },
];
const List comingSoonJson = [
  {
    "img": "assets/images/black_mirror.jpg",
    "title_img": "assets/images/black_mirror_title.png",
    "title": "Sentinelle",
    "description":
        "Considered a fool and unfit to lead, Nobunaga rises to power as the head of the Oda clan, spurring dissent among those in his family vying for control.",
    "type": "Gritty - Dark - Action Thriller - Action & Adventure - Drama",
    "date": "Coming Friday",
    "duration": true
  },
  {
    "img": "assets/images/banner_1.webp",
    "title_img": "assets/images/title_img_1.webp",
    "title": "Vincenzo",
    "description":
        "During a visit to his motherland, a Korean-Italian mafia lawyer gives an unrivaled conglomerate a taste of its own medicine with a side of justice.",
    "type": "Gritty - Dark - Action Thriller - Action & Adventure - Drama",
    "date": "New Episode Coming Saturday",
    "duration": false
  },
  {
    "img": "assets/images/banner_2.webp",
    "title_img": "assets/images/title_img_2.webp",
    "title": "Peaky Blinders",
    "description":
        "A notorious gang in 1919 Birmingham, England, is led by the fierce Tommy Shelby, a crime boss set on moving up in the world no matter the cost.",
    "type": "Violence, Sex, Nudity, Language, Substances",
    "date": "2021 June",
    "duration": false
  }
];
