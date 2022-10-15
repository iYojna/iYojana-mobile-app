import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iyojana/scheme/scheme_category.dart';

class SchemeCategoryDetailPage extends StatefulWidget {
  final SchemeCategory category;
  const SchemeCategoryDetailPage({Key? key, required this.category})
      : super(key: key);
  static const routeName = 'scheme_category_detail_page';
  @override
  State<SchemeCategoryDetailPage> createState() =>
      _SchemeCategoryDetailPageState();
}

class _SchemeCategoryDetailPageState extends State<SchemeCategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.category.name,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Wrap(
                  children: [
                    Text(widget.category.description,
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16))),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: widget.category.isFollwed
                            ? MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 164, 164, 164))
                            : MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        //Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                          widget.category.isFollwed ? "Following" : "Follow")),
                ),
                const SizedBox(
                  height: 30,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: widget.category.schemes.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    print("OK");
                    return Card(
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                      image: NetworkImage(widget.category.schemes[i].posterUrl),
                    ))));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
