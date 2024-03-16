import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

import 'package:screen_pal/common/constants.dart';
import 'package:screen_pal/interfaces/widgets.dart';
import 'package:screen_pal_core/screen_pal_core.dart';

// 7:2 ratio
const _kCardW = 450.0;
const _kCardH = (2 * _kCardW) / 7;

class CreditsViewBody extends StatelessWidget {
  const CreditsViewBody(this.credits, {super.key});

  final CreditsBase credits;

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: ScrollController(),
      child: LayoutBuilder(builder: (context, box) {
        final maxW = box.maxWidth;

        if (maxW >= (_kCardW * 2)) return _WideLayoutView(credits);

        return _ThinLayoutView(credits);
      }),
    );
  }
}

Widget _itemCard(CreditPerson person) {
  return SizedCreditPersonDetailCard(person, width: _kCardH, height: _kCardH);
}

class _ThinLayoutView extends StatelessWidget {
  const _ThinLayoutView(this.credits);

  final CreditsBase credits;

  bool get hasCasts => credits.casts.isNotEmpty;
  int get castsLen => credits.casts.length;

  bool get hasCrews => credits.crews.isNotEmpty;

  int _computeItemLength(int itemCount) {
    return itemCount +
        (!hasCasts
            ? 1
            : hasCrews
                ? 2
                : 1);
  }

  @override
  Widget build(BuildContext context) {
    final persons = [...credits.casts, ...credits.crews];

    return CustomListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _computeItemLength(persons.length),
      itemBuilder: (context, index) {
        if (index == 0) {
          final String text = switch (hasCasts) {
            true => 'Casts',
            false => 'Crews',
          };

          return CustomListViewItemDelegate(
            crossAxisLength: _kCardW,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                text,
                style: kSectionTitleStyle(context),
              ),
            ),
          );
        }

        if (index > castsLen && hasCasts && hasCrews) {
          if (index == castsLen + 1) {
            return CustomListViewItemDelegate(
              crossAxisLength: _kCardW,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Crews',
                  style: kSectionTitleStyle(context),
                ),
              ),
            );
          }
          final crew = persons[index - 2];

          return CustomListViewItemDelegate(
            mainAxisLength: _kCardH,
            crossAxisLength: _kCardW,
            child: _itemCard(crew),
          );
        }

        // can be crew if casts is empty
        final person = persons[index - 1];

        return CustomListViewItemDelegate(
          mainAxisLength: _kCardH,
          crossAxisLength: _kCardW,
          child: _itemCard(person),
        );
      },
    );
  }
}

class _WideLayoutView extends StatelessWidget {
  const _WideLayoutView(this.credits);

  final CreditsBase credits;

  List<CreditPerson> get casts => credits.casts;
  List<CreditPerson> get crews => credits.crews;

  @override
  Widget build(BuildContext context) {
    return casts.isEmpty && crews.isEmpty
        ? const SizedExceptionWidget(BasicException())
        : Padding(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <List<Widget>>[
                // casts
                [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: _kCardW,
                      child: Text('Casts', style: kSectionTitleStyle(context)),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: casts.isEmpty
                        ? const Center(child: Text('No cast data for now'))
                        : CustomListView.builder(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            crossAxisAlignment: CustomListViewItemAlignment.end,
                            itemCount: casts.length,
                            itemBuilder: (_, index) {
                              return CustomListViewItemDelegate(
                                mainAxisLength: _kCardH,
                                crossAxisLength: _kCardW,
                                child: _itemCard(casts[index]),
                              );
                            },
                          ),
                  ),
                ],

                // crews
                [
                  Text('Crews', style: kSectionTitleStyle(context)),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: crews.isEmpty
                        ? const Center(
                            child: Text('No crew data for now'),
                          )
                        : CustomListView.builder(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            crossAxisAlignment:
                                CustomListViewItemAlignment.start,
                            itemCount: crews.length,
                            itemBuilder: (_, index) {
                              return CustomListViewItemDelegate(
                                mainAxisLength: _kCardH,
                                crossAxisLength: _kCardW,
                                child: _itemCard(crews[index]),
                              );
                            },
                          ),
                  )
                ],
              ].map<Widget>((e) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: e,
                  ),
                );
              }).toList()
                // list divider
                ..insert(1, const SizedBox(width: 16.0)),
            ),
          );
  }
}
