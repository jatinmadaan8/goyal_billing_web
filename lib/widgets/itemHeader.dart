import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItemHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Container(
          //     constraints: BoxConstraints(minWidth: 32),
          //     child: Text(
          //       "Number",
          //       style: GoogleFonts.mitr(fontSize: 16),
          //       textAlign: TextAlign.end,
          //     )),
          Expanded(
              flex: 1,
              child: Text(
                "Item Name",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "Price Unit",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "Quantity",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "Total",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            width: 44,
          ),
        ],
      ),
    );
  }
}