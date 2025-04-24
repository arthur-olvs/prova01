- Arthur de Oliveira e Silva
- Kaue Castro Teixeira

## Documentação Prototipo01

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

## 2. Row
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

## 3. Wrap
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

## 4. Expanded
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

## 5. Stack
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

## 6. ListView.builder
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

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Documentação Prototipo02

## 1. Column
Pra que serve?
Organiza os elementos da tela de cima para baixo, como se fosse uma pilha vertical.

Onde usei?
Na tela principal da calculadora de IMC, para colocar o ícone de peso, os campos de entrada (peso e altura), o botão de calcular, a área de resultado e a tabela de IMC um abaixo do outro.

Como funciona no código?

Dart

Column(
  crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os filhos horizontalmente
  children: <Widget>[
    Icon(Icons.monitor_weight, size: 60, color: Colors.blue),
    SizedBox(height: 20),
    Row(
      // ...
    ),
    SizedBox(height: 20),
    Align(
      // ...
    ),
    SizedBox(height: 30),
    if (imcResult != null)
      Container(
        // ...
      )
    else if (imcCategory.isNotEmpty)
      Padding(
        // ...
      ),
    SizedBox(height: 30),
    Text(
      // ...
    ),
    SizedBox(height: 10),
    Table(
      // ...
    ),
  ],
)
Elementos Utilizados: Icon, SizedBox, Row, Align, Container, Padding, Text, Table.

## 2. Row
Pra que serve?
Alinha os elementos lado a lado, horizontalmente.

Onde usei?
Para colocar os campos de "Peso (kg)" e "Altura (m)" um ao lado do outro na tela de entrada de dados.

Como funciona no código?

Dart

Row(
  children: <Widget>[
    Expanded(
      child: TextField(
        controller: weightController,
        decoration: const InputDecoration(
          labelText: 'Peso (kg)',
          border: OutlineInputBorder(),
        ),
      ),
    ),
    SizedBox(width: 10),
    Expanded(
      child: TextField(
        controller: heightController,
        decoration: const InputDecoration(
          labelText: 'Altura (m)',
          border: OutlineInputBorder(),
        ),
      ),
    ),
  ],
)
Elementos Utilizados: Expanded, TextField, SizedBox, InputDecoration, OutlineInputBorder.

## 3. Align / Center
Pra que serve?
Align permite alinhar um widget dentro de seu pai de diversas formas. Center é um jeito fácil de centralizar um widget.

Onde usei?
Para centralizar o botão "Calcular IMC" horizontalmente na tela. O AppBar também usa uma propriedade para centralizar o título.

Como funciona no código?

Dart

Align(
  alignment: Alignment.center,
  child: ElevatedButton(
    onPressed: _calculateIMC,
    child: const Text('Calcular IMC'),
  ),
)
Elementos Utilizados: ElevatedButton, Text. No AppBar, a propriedade centerTitle: true é usada.

## 4. Container com BoxDecoration
Pra que serve?
Container é um widget genérico para agrupar outros widgets e aplicar estilos. BoxDecoration permite definir a aparência visual do container (cor de fundo, borda, etc.).

Onde usei?
Para criar um bloco visual destacado para exibir o resultado do IMC, com uma cor de fundo suave e bordas arredondadas.

Como funciona no código?

Dart

Container(
  padding: const EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
    // ...
  ),
)
Elementos Utilizados: Column, Text, BoxDecoration, Colors, BorderRadius.

## 5. Flexible e Expanded
Pra que serve?
Tornam os widgets filhos de um Row, Column ou Flex flexíveis, permitindo que eles ocupem o espaço disponível de maneira proporcional. Expanded é um Flexible com um fator de flex padrão de 1, ocupando todo o espaço restante igualmente entre outros Expanded na mesma linha/coluna.

Onde usei?
O Expanded foi usado dentro da Row dos campos de peso e altura para garantir que cada campo de texto ocupasse metade da largura disponível.

Como funciona no código?

Dart

Row(
  children: <Widget>[
    Expanded(
      child: TextField(
        // ...
      ),
    ),
    SizedBox(width: 10),
    Expanded(
      child: TextField(
        // ...
      ),
    ),
  ],
)
Elementos Utilizados: TextField, SizedBox, InputDecoration, OutlineInputBorder.

## 6. Table
Pra que serve?
Organiza os widgets em um formato de tabela, com linhas e colunas.

Onde usei?
Para exibir a tabela de categorias de IMC e suas respectivas faixas de valores de forma estruturada.

Como funciona no código?

Dart

Table(
  border: TableBorder.all(),
  columnWidths: const {
    0: FlexColumnWidth(),
    1: FlexColumnWidth(),
  },
  children: const [
    TableRow(
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text('IMC', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    ),
    // ... outras TableRow ...
  ],
)
Elementos Utilizados: TableBorder, FlexColumnWidth, TableRow, Padding, Text, TextStyle.

