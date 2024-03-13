import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_assessment/models/user_model.dart';
import 'package:map_assessment/riverpod/api_riverpod.dart';

class SecondScreen extends ConsumerWidget {
  final String address;
  const SecondScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        automaticallyImplyLeading: false,
        title: Text(address),
      ),
      body: FutureBuilder<UserModel>(
        future: ref.read(apiServiceProvider).fetchDataForAddress(address),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data!.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    shape: const BeveledRectangleBorder(
                        side: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Text("${user.firstName!} ${user.lastName!}"),
                    leading: Image.network(user.avatar!),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Error fetching data');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
