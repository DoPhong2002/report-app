import 'package:exercise_demo/bloc/issue_bloc.dart';
import 'package:exercise_demo/models/issue.dart';
import 'package:flutter/material.dart';

class ItemReport extends StatelessWidget {
  final Issue issue;

  const ItemReport({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueAccent)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildTitleReport(), buildStatusReport(), buildListImage()],
      ),
    );
  }

  Widget buildTitleReport() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Image.network(
                  issue.accountPublic?.avatar ??
                      'https://scr.vn/wp-content/uploads/2020/07/Avatar-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-m%C3%A0u-s%E1%BA%AFc.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(issue.accountPublic!.name ?? ''),
                Text(issue.createdAt ?? ''),
              ],
            ),
          ],
        ),
        const Text('Khong duyet'),
      ],
    );
  }

  Widget buildStatusReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(issue.title ?? ''),
        Text(issue.content ?? ''),
        const SizedBox(height: 8)
      ],
    );
  }

  int cuontGridView() {
    int? a = issue.photos?.length;
    if (a == 2) {
      return a = 2;
    } else if (a == 1) {
      return a = 1;
    }
    return a = 2;
  }

  int cuontView() {
    return issue.photos?.length ?? 0;
  }

  Widget buildListImage() {
    if (cuontView() > 4) {

    } else if (cuontView() == 0) {
      return Container();
    }

    final photos = issue.photos ?? [];
    final count = photos.length;
    if (count == 0){
      return Container();
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: count > 4 ? 4 : count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count == 1 ? 1 : 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (_, index) {
        final photo = photos[index];
        if (index == 3) {
          return Center(
            child: Stack(
              children: [
                Image.network(
                  'https://i1-vnexpress.vnecdn.net/2022/10/25/-2402-1666690727.jpg?w=680&h=408&q=100&dpr=1&fit=crop&s=8fbJV5TjTN-4GFkwZxshAw',
                  fit: BoxFit.cover,
                ),
                Text(
                  "+${count - 4}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Colors.cyanAccent.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          );
        }
        return Image.network(
          'https://i1-vnexpress.vnecdn.net/2022/10/25/-2402-1666690727.jpg?w=680&h=408&q=100&dpr=1&fit=crop&s=8fbJV5TjTN-4GFkwZxshAw',
          fit: BoxFit.cover,
        );
      },
    );
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: issue.photos!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (_, index) {
        final image = issue.photos![index];

        return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ));
      },
    );
  }
}
