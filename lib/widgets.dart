import 'package:flutter/material.dart';

typedef StringCallback = Function(BuildContext, String);

class ListScreen extends StatelessWidget {
  const ListScreen({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final StringCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List')),
      body: ListView.builder(
        itemBuilder: (context, id) => ListTile(
          title: Text('Item: $id'),
          onTap: () => this.onSelected(context, '$id'),
        ),
        itemCount: 1000,
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  final String id;
  final StringCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail for $id')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('INDEX: $id'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => onTap(context, id),
              child: Text('to final page'),
            )
          ],
        ),
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  const FinalScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Final Screen')),
      body: Center(child: Text('Can only go back from here.')),
    );
  }
}
