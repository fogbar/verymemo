import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/barrel/button.dart';
// import 'package:verymemo/features/memo/presentation/memo_home_viewmodel.dart';
// import 'package:verymemo/features/memo/presentation/memo_delete_viewmodel.dart';

class MemoDeleteView extends StatelessWidget {
  const MemoDeleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: RoundBtn(
                  text: '복원',
                  onPressed: () {},
                  size: BoxSize.medium,
                  state: ButtonState.secondary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RoundBtn(
                  text: '휴지통 비우기',
                  onPressed: () {},
                  size: BoxSize.medium,
                  state: ButtonState.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
