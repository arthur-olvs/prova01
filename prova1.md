- Arthur de Oliveira e Silva
- Kaue Castro Teixeira

## 1. Column

**Pra que serve?**
Organiza os elementos da tela de cima para baixo, como se fosse uma pilha vertical.

**Onde usei?**
Na tela principal (`MenuScreen`), coloquei os filtros de categoria em cima e a lista de pratos embaixo, tudo alinhado verticalmente.

**Como funciona no código?**
dart
Column(
  children: <Widget>[
    // A parte dos filtros
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 8.0,
          children: <Widget>[
            // Os botões de filtro
          ],
        ),
      ),
    ),
    // A lista de pratos, ocupando o resto da tela
    Expanded(
      child: ListView.builder(
        // Os cards dos pratos
      ),
    ),
  ],
)

2. Row
Pra que serve?
Alinha os elementos lado a lado, horizontalmente.

Onde usei?
Dentro de cada cartão de prato, usei para colocar a (antiga) imagem, o texto com o nome e a descrição, e o botão de "Detalhes" um ao lado do outro. Também no topo (AppBar) para o título e os ícones ficarem lado a lado.

Como funciona no código?

Dart

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
            // Nome e descrição do prato
          ],
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () {
          // Mostrar detalhes
        },
        child: const Text('Detalhes'),
      ),
    ),
  ],
)

3. Wrap
Pra que serve?
Coloca os elementos lado a lado até não caberem mais na largura, aí joga eles pra linha de baixo.

Onde usei?
Para mostrar os botões de filtro das categorias. Se tiver muitos filtros, eles não vão ficar apertados numa linha só, vão quebrar para a linha seguinte.

Como funciona no código?

Dart

Wrap(
  spacing: 8.0, // Espacinho entre os botões
  children: <Widget>[
    FilterChip(
      label: const Text('Todos'),
      selected: _selectedCategory == null || _selectedCategory == 'Todos',
      onSelected: (bool selected) {
        // Filtrar tudo ou nada
      },
    ),
    // Outros botões de filtro
  ],
)

4. Expanded
Pra que serve?
Faz um elemento ocupar todo o espaço que sobrar dentro de um Row, Column ou Flex.

Onde usei?
No Row de cada prato, o texto com o nome e a descrição usa Expanded pra ocupar o espaço entre a (antiga) imagem e o botão. Também a lista de pratos (ListView.builder) usa Expanded pra pegar toda a altura que sobrar depois dos filtros.

Como funciona no código?

Dart

Row(
  children: <Widget>[
    // Outros elementos
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Textos do prato
          ],
        ),
      ),
    ),
    // Outro elemento
  ],
)

5. Stack
Pra que serve?
Coloca os elementos um em cima do outro.

Onde usei?
Dentro do cartão de cada prato, usei pra colocar aquele selo de desconto verde no cantinho superior esquerdo, por cima do resto do conteúdo.

Como funciona no código?

Dart

Stack(
  children: <Widget>[
    Row(
      // O conteúdo normal do prato
    ),
    if (item.discount != null)
      Positioned(
        top: 12.0,
        left: 12.0,
        child: Container(
          // O selo de desconto
        ),
      ),
  ],
)

6. ListView.builder
Pra que serve?
Mostra uma lista de coisas que dá pra rolar. A diferença é que ele só cria os itens da lista quando eles estão quase aparecendo na tela, o que economiza memória pra listas grandes.

Onde usei?
Pra mostrar a lista de todos os pratos (ou dos pratos filtrados). Assim, se tiver muitos pratos, o aplicativo não vai ficar lento carregando tudo de uma vez.

Como funciona no código?

Dart

Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemCount: _filteredMenuItems.length,
    itemBuilder: (context, index) {
      final item = _filteredMenuItems[index];
      return Card(
        // O visual de cada prato
      );
    },
  ),
)
