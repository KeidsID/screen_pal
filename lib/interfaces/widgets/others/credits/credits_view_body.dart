import 'package:flutter/material.dart';
import 'package:screen_pal/common/constants.dart';

import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/interfaces/utils.dart';
import 'package:screen_pal/interfaces/widgets.dart';

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

  int _computeItemLen(int itemCount) {
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

    return Stack(
      fit: StackFit.expand,
      children: [
        // scrollable area
        const SizedScrollableArea(primary: true),

        // contents
        persons.isEmpty
            ? const SizedExceptionWidget(BasicException())
            : Center(
                child: SizedBox(
                  width: _kCardW,
                  height: double.infinity,
                  child: ListView.builder(
                    primary: true,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _computeItemLen(persons.length),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final String text = switch (hasCasts) {
                          true => 'Casts',
                          false => 'Crews',
                        };

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            text,
                            style: kSectionTitleStyle.toStyle(context),
                          ),
                        );
                      }

                      if (index > castsLen && hasCasts && hasCrews) {
                        if (index == castsLen + 1) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Crews',
                              style: kSectionTitleStyle.toStyle(context),
                            ),
                          );
                        }
                        final crew = persons[index - 2];

                        return _itemCard(crew);
                      }

                      // can be crew if casts is empty
                      final person = persons[index - 1];

                      return _itemCard(person);
                    },
                  ),
                ),
              ),
      ],
    );
  }
}

final class _WideLayoutView extends StatefulWidget {
  const _WideLayoutView(this.credits);

  final CreditsBase credits;

  @override
  State<_WideLayoutView> createState() => _WideLayoutViewState();
}

class _WideLayoutViewState extends State<_WideLayoutView> {
  late final ScrollController _crewsScrollCtrler;

  @override
  void initState() {
    super.initState();

    _crewsScrollCtrler = ScrollController();
  }

  @override
  void dispose() {
    _crewsScrollCtrler.dispose();

    super.dispose();
  }

  List<CreditPerson> get casts => widget.credits.casts;
  List<CreditPerson> get crews => widget.credits.crews;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //scrollable area
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedScrollableArea(primary: true),
            SizedScrollableArea(controller: _crewsScrollCtrler),
          ].map((e) => Expanded(child: e)).toList(),
        ),

        // contents
        casts.isEmpty && crews.isEmpty
            ? const SizedExceptionWidget(BasicException())
            : Center(
                child: SizedBox(
                  width: _kCardW * 2,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <List<Widget>>[
                        // casts
                        [
                          Text(
                            'Casts',
                            style: kSectionTitleStyle.toStyle(context),
                          ),
                          const SizedBox(height: 8.0),
                          Expanded(
                            child: casts.isEmpty
                                ? const Center(
                                    child: Text('No cast data for now'),
                                  )
                                : ListView.builder(
                                    primary: true,
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    itemCount: casts.length,
                                    itemBuilder: (_, index) =>
                                        _itemCard(casts[index]),
                                  ),
                          ),
                        ],

                        // crews
                        [
                          Text(
                            'Crews',
                            style: kSectionTitleStyle.toStyle(context),
                          ),
                          const SizedBox(height: 8.0),
                          Expanded(
                            child: crews.isEmpty
                                ? const Center(
                                    child: Text('No crew data for now'),
                                  )
                                : ListView.builder(
                                    controller: _crewsScrollCtrler,
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    itemCount: crews.length,
                                    itemBuilder: (_, index) =>
                                        _itemCard(crews[index]),
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
                        // list seperator
                        ..insert(1, const SizedBox(width: 16.0)),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
