import '../models/menu_item.dart';

const List<String> menuCategories = <String>[
  'Espresso Bar',
  'Cold and Blended',
  'Garden Specials',
  'Light Bites',
  'Desserts',
];

const List<MenuItem> cafeMenuItems = <MenuItem>[
  MenuItem(
    name: 'Americano',
    description: 'Bold espresso balanced with hot water.',
    price: '₱100',
    category: 'Espresso Bar',
  ),
  MenuItem(
    name: 'Cappuccino',
    description: 'Foamy and velvety with rich espresso.',
    price: '₱120',
    category: 'Espresso Bar',
  ),
  MenuItem(
    name: 'Cafe Latte',
    description: 'Smooth espresso with steamed milk.',
    price: '₱130',
    category: 'Espresso Bar',
  ),
  MenuItem(
    name: 'Flat White',
    description: 'Silky milk over a double shot espresso.',
    price: '₱130',
    category: 'Espresso Bar',
  ),
  MenuItem(
    name: 'Caramel Macchiato',
    description: 'Vanilla latte with caramel drizzle.',
    price: '₱150',
    category: 'Espresso Bar',
  ),
  MenuItem(
    name: 'Cold Brew',
    description: 'Slow-steeped and naturally sweet coffee.',
    price: '₱140',
    category: 'Cold and Blended',
  ),
  MenuItem(
    name: 'Iced Latte',
    description: 'Espresso, milk, and ice for warm afternoons.',
    price: '₱140',
    category: 'Cold and Blended',
  ),
  MenuItem(
    name: 'Vanilla Frappe',
    description: 'Creamy blended vanilla coffee treat.',
    price: '₱160',
    category: 'Cold and Blended',
  ),
  MenuItem(
    name: 'Mocha Frappe',
    description: 'Chocolate and coffee blended with ice.',
    price: '₱160',
    category: 'Cold and Blended',
  ),
  MenuItem(
    name: 'Sea Salt Latte',
    description: 'Cold latte with a sweet-salty foam top.',
    price: '₱155',
    category: 'Cold and Blended',
  ),
  MenuItem(
    name: 'Matcha Latte',
    description: 'Earthy Japanese matcha and fresh milk.',
    price: '₱150',
    category: 'Garden Specials',
  ),
  MenuItem(
    name: 'Butterfly Pea Lemonade',
    description: 'Citrus refresher with floral blue pea tea.',
    price: '₱130',
    category: 'Garden Specials',
  ),
  MenuItem(
    name: 'Taro Milk Tea',
    description: 'Nutty taro blend with creamy finish.',
    price: '₱140',
    category: 'Garden Specials',
  ),
  MenuItem(
    name: 'Mango Smoothie',
    description: 'Tropical mango blend served chilled.',
    price: '₱150',
    category: 'Garden Specials',
  ),
  MenuItem(
    name: 'Cucumber Mint Cooler',
    description: 'Light and fresh garden-inspired cooler.',
    price: '₱125',
    category: 'Garden Specials',
  ),
  MenuItem(
    name: 'Club Sandwich',
    description: 'Grilled chicken, lettuce, tomato, and cheese.',
    price: '₱200',
    category: 'Light Bites',
  ),
  MenuItem(
    name: 'Garden Salad',
    description: 'Seasonal greens with citrus vinaigrette.',
    price: '₱180',
    category: 'Light Bites',
  ),
  MenuItem(
    name: 'Waffle with Syrup',
    description: 'Golden waffle with maple drizzle.',
    price: '₱160',
    category: 'Light Bites',
  ),
  MenuItem(
    name: 'Banana Pancakes',
    description: 'Fluffy stack with caramelized banana.',
    price: '₱150',
    category: 'Light Bites',
  ),
  MenuItem(
    name: 'Pesto Toast',
    description: 'Toasted sourdough with herby pesto spread.',
    price: '₱145',
    category: 'Light Bites',
  ),
  MenuItem(
    name: 'Chocolate Lava Cake',
    description: 'Warm center with rich dark chocolate.',
    price: '₱160',
    category: 'Desserts',
  ),
  MenuItem(
    name: 'Cheesecake Slice',
    description: 'Creamy baked cheesecake, cafe favorite.',
    price: '₱140',
    category: 'Desserts',
  ),
  MenuItem(
    name: 'Banana Bread',
    description: 'Moist loaf with toasted walnuts.',
    price: '₱80',
    category: 'Desserts',
  ),
  MenuItem(
    name: 'Chocolate Chip Cookies',
    description: 'Soft center, crisp edges, daily baked.',
    price: '₱60',
    category: 'Desserts',
  ),
  MenuItem(
    name: 'Ube Tres Leches',
    description: 'Filipino-inspired milky sponge cake.',
    price: '₱150',
    category: 'Desserts',
  ),
];
