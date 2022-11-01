import 'package:hp_api/src/get_sentences/sentence_controller.dart';
import 'package:hp_api/src/get_sentences/sentence_repository.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = SentenceController(repository: SentenceRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: controller.getSentence(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Não há dados para mostrar!'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ProfilePicture(picture: snapshot.data![index].image),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            snapshot.data![index].name!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            snapshot.data![index].house!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final String? picture;
  const ProfilePicture({required this.picture, super.key});

  @override
  Widget build(BuildContext context) {
    return picture != null && picture!.isNotEmpty
        ? Image.network(picture!, width: 100, height: 100)
        : const Icon(
            Icons.person,
            size: 100,
          );
  }
}
