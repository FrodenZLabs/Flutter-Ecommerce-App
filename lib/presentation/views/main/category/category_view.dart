import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/category_card.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 8,),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextField(
                controller: _textEditingController,
                autofocus: false,
                onSubmitted: (val) {},
                onChanged: (val) => setState(() {}),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20, bottom: 22, top: 22),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: _textEditingController.text.isEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.clear)
                    ),
                  ) : null,
                  border: const OutlineInputBorder(),
                  hintText: "Search category",
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 3.0),
                    borderRadius: BorderRadius.circular(26)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: const BorderSide(color: Colors.white, width: 3.0)
                  )
              ),
            ),
            ),
            Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    padding: EdgeInsets.only(top: 14,
                    bottom: (80 + MediaQuery.of(context).padding.bottom)),
                    itemBuilder: (context, index) => CategoryCard()
                )
            )
          ],
        ),
      ),
    );
  }
}
