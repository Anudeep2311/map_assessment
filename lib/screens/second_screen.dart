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
      backgroundColor: Colors.teal.shade100,
      // ^_^ PASSED ADDRESS ^_^
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal.shade100,
        automaticallyImplyLeading: false,
        title: Text(address),
      ),
      // ^_^ LIST DATA ^_^
      body: FutureBuilder<UserModel>(
        future: ref.read(apiServiceProvider).fetchDataForAddress(address),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data!.data![index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.teal.shade800)),
                    title: Text("${user.firstName!} ${user.lastName!}"),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar!),
                    ),
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
