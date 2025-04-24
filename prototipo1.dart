import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardápio Japonês',
      theme: ThemeData(
        primarySwatch: Colors.red,
        hintColor: Colors.grey[400],
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.redAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[300],
          selectedColor: Colors.redAccent,
          labelStyle: const TextStyle(color: Colors.black87),
          secondaryLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.green,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: const MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String? _selectedCategory;
  final List<MenuItem> _menuItems = [
    MenuItem(
      name: 'Sushi Especial Salmão',
      description:
          'Deliciosas fatias de salmão fresco sobre arroz japonês temperado.',
      category: 'Sushi',
      nutrition: {
        'Calorias': '250 kcal',
        'Proteínas': '15g',
        'Carboidratos': '30g',
        'Gorduras': '8g',
      },
      discount: null,
      price: 25.90,
      imageUrl: '',
    ),
    MenuItem(
      name: 'Ramen Clássico Tonkotsu',
      description:
          'Caldo cremoso de porco com macarrão artesanal, ovo cozido, carne de porco e cebolinha.',
      category: 'Ramen',
      nutrition: {
        'Calorias': '480 kcal',
        'Proteínas': '25g',
        'Carboidratos': '55g',
        'Gorduras': '20g',
      },
      discount: 15,
      price: 38.50,
      imageUrl: '',
    ),
    MenuItem(
      name: 'Temaki Salmão Completo',
      description:
          'Cone de alga marinha recheado com salmão, cream cheese, cebolinha e gergelim.',
      category: 'Temaki',
      nutrition: {
        'Calorias': '320 kcal',
        'Proteínas': '18g',
        'Carboidratos': '35g',
        'Gorduras': '12g',
      },
      discount: null,
      price: 18.75,
      imageUrl: '',
    ),
    MenuItem(
      name: 'Sashimi de Atum',
      description: 'Fatias finas e frescas de atum.',
      category: 'Sashimi',
      nutrition: {
        'Calorias': '180 kcal',
        'Proteínas': '28g',
        'Carboidratos': '2g',
        'Gorduras': '5g',
      },
      discount: 10,
      price: 32.00,
      imageUrl: '',
    ),
    MenuItem(
      name: 'Mochi de Morango',
      description:
          'Bolinho de arroz glutinoso recheado com morango e pasta de feijão doce.',
      category: 'Sobremesas',
      nutrition: {
        'Calorias': '120 kcal',
        'Proteínas': '2g',
        'Carboidratos': '25g',
        'Gorduras': '1g',
      },
      discount: null,
      price: 12.50,
      imageUrl: '',
    ),
  ];

  List<MenuItem> get _filteredMenuItems {
    if (_selectedCategory == null || _selectedCategory == 'Todos') {
      return _menuItems;
    } else {
      return _menuItems
          .where((item) => item.category == _selectedCategory)
          .toList();
    }
  }

  void _showNutritionDetails(MenuItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Preço: R\$ ${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Informação Nutricional:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Table(
                  border: TableBorder.all(color: Colors.grey[300]!),
                  columnWidths: const {
                    0: FixedColumnWidth(120),
                    1: FixedColumnWidth(100),
                  },
                  children: item.nutrition.entries.map((entry) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(entry.value),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Pedir'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('"${item.name}" adicionado ao pedido!')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant, size: 32),
              SizedBox(width: 8.0),
              Text('Tuiuti Sushi', style: TextStyle(fontFamily: 'Serif')),
              SizedBox(width: 8.0),
              Icon(Icons.local_dining, size: 32),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0,
                children: <Widget>[
                  FilterChip(
                    label: const Text('Todos'),
                    selected:
                        _selectedCategory == null || _selectedCategory == 'Todos',
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategory = selected ? 'Todos' : null;
                      });
                    },
                  ),
                  ..._menuItems.map((item) => item.category).toSet().map((
                    category,
                  ) {
                    return FilterChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredMenuItems.length,
              itemBuilder: (context, index) {
                final item = _filteredMenuItems[index];
                return Card(
                  child: Stack(
                    children: [
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: const SizedBox(
                              width: 120,
                              height: 120,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    'R\$ ${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _showNutritionDetails(item);
                              },
                              child: const Text('Detalhes'),
                            ),
                          ),
                        ],
                      ),
                      if (item.discount != null)
                        Positioned(
                          top: 12.0,
                          left: 12.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent[400],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              '-${item.discount}%',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String description;
  final String category;
  final Map<String, String> nutrition;
  final int? discount;
  final double price;
  final String imageUrl;

  MenuItem({
    required this.name,
    required this.description,
    required this.category,
    required this.nutrition,
    this.discount,
    required this.price,
    required this.imageUrl,
  });
}
