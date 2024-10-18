import 'package:flutter/material.dart';
/*
class MultiplicationTable extends StatelessWidget {
  final int tableSize = 10;

  const MultiplicationTable({super.key}); // 10x10 multiplication table

  // Function to generate multiplication table with missing values
  List<List<int?>> generateTable() {
    List<List<int?>> table = [];
    for (int i = 1; i <= tableSize; i++) {
      List<int?> row = [];
      for (int j = 1; j <= tableSize; j++) {
        // Condition to leave some values missing (null), e.g., i * j = even
        if ((i * j) % 2 == 0) {
          row.add(null); // Set to null for missing value
        } else {
          row.add(i * j);
        }
      }
      table.add(row);
    }
    return table;
  }

  @override
  Widget build(BuildContext context) {
    List<List<int?>> tableData = generateTable();

    return Scaffold(
      appBar: AppBar(title: Text('Multiplication Table')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: tableSize, // Number of columns
            childAspectRatio: 1.5,
          ),
          itemCount: tableSize * tableSize,
          itemBuilder: (context, index) {
            int row = index ~/ tableSize;
            int col = index % tableSize;
            int? value = tableData[row][col];

            return Card(
              color: value == null ? Colors.grey[300] : Colors.white,
              child: Center(
                child: Text(
                  value?.toString() ?? '', // Display blank for missing values
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/
/*
class MultiplicationTable extends StatefulWidget {
  @override
  _MultiplicationTableState createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable> {
  final int tableSize = 10; // Fixed table size (10x10)
  int selectedTable = 1; // Default multiplication table
  TextEditingController tableController = TextEditingController();

  // Function to generate the selected multiplication table with some missing values
  List<List<int?>> generateTable(int multiplier) {
    List<List<int?>> table = [];
    for (int i = 1; i <= tableSize; i++) {
      List<int?> row = [];
      for (int j = 1; j <= tableSize; j++) {
        // Here you can add custom logic to mark some values as missing
        if (i * j == multiplier * i && (i * j) % 2 == 0) {
          row.add(null); // Leave this value missing
        } else {
          row.add(multiplier * i);
        }
      }
      table.add(row);
    }
    return table;
  }

  @override
  Widget build(BuildContext context) {
    List<List<int?>> tableData = generateTable(selectedTable);

    return Scaffold(
      appBar: AppBar(
        title: Text('Multiplication Table'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tableController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter the multiplication table (e.g., 8)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedTable = int.parse(tableController.text); // Update table
                });
              },
              child: Text('Generate Table'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: tableSize, // Number of columns
                  childAspectRatio: 1.5,
                ),
                itemCount: tableSize * tableSize,
                itemBuilder: (context, index) {
                  int row = index ~/ tableSize;
                  int col = index % tableSize;
                  int? value = tableData[row][col];

                  return Card(
                    color: value == null ? Colors.grey[300] : Colors.white,
                    child: Center(
                      child: Text(
                        value?.toString() ?? '', // Display blank for missing values
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

class MultiplicationTable extends StatefulWidget {
  @override
  _MultiplicationTableState createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable> {
  int selectedTable = 1; // Default multiplication table
  TextEditingController tableController = TextEditingController();

  // Function to generate the selected multiplication table
  List<String> generateTable(int multiplier) {
    List<String> table = [];
    for (int i = 1; i <= 10; i++) {
      table.add('$multiplier * $i = ${multiplier * i}');
    }
    return table;
  }

  @override
  Widget build(BuildContext context) {
    List<String> tableData = generateTable(selectedTable);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiplication Table'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tableController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter the multiplication table (e.g., 8)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedTable = int.parse(tableController.text); // Update table
                });
              },
              child: const Text('Generate Table'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tableData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      tableData[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}