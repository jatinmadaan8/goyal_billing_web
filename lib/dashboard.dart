import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gs_web/widgets/form_widget.dart';
import 'package:gs_web/widgets/mycard.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildNavBar(),
          FormWidget(),
        ],
      ),
    );
  }

  Widget buildNavBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey[100], width: 2))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Goyal Sales",
                  style: GoogleFonts.mitr(fontSize: 25),
                  textAlign: TextAlign.end,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.print), 
                  onPressed: (){},
                  )
            ],
          ),
          ),
        ],
      ),
    );
  }
}