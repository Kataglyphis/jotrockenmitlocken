import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/constants.dart';

class Footer extends StatefulWidget {
  const Footer({
    super.key,
  });

  @override
  State<Footer> createState() => _Footer();
}

class _Footer extends State<Footer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180.0,
        child: Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                      child: Column(
                    children: [],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Text abc",
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Text abc"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Text abc"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Text abc"),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Text abc",
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Text abc"),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Text abc",
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Text abc"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Text abc"),
                      ),
                    ],
                  )),
                  const Expanded(
                      child: Column(
                    children: [],
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
