// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'semantics_tester.dart';

void main() {
  testWidgets('Semantics 5', (WidgetTester tester) async {
    final SemanticsTester semantics = new SemanticsTester(tester);

    await tester.pumpWidget(
      new Stack(
        textDirection: TextDirection.ltr,
        fit: StackFit.expand,
        children: <Widget>[
          new Semantics(
            // this tests that empty nodes disappear
          ),
          new Semantics(
            // this tests whether you can have a container with no other semantics
            container: true,
          ),
          new Semantics(
            label: 'label', // (force a fork)
            textDirection: TextDirection.ltr,
          ),
        ]
      )
    );

    expect(semantics, hasSemantics(
      new TestSemantics.root(
        children: <TestSemantics>[
          new TestSemantics.rootChild(
            id: 1,
            nextNodeId: 2,
            rect: TestSemantics.fullScreen,
          ),
          new TestSemantics.rootChild(
            id: 2,
            previousNodeId: 1,
            label: 'label',
            rect: TestSemantics.fullScreen,
          ),
        ]
      )
    ));

    semantics.dispose();
  });
}
