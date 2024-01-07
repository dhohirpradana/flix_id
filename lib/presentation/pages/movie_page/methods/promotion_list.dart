import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> promotionList(List<String> promotionImageFileNames) => [
      Padding(
        padding: EdgeInsets.only(left: 24, bottom: 15),
        child: Text(
          'Promotions',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: promotionImageFileNames
              .map(
                (fileName) => Container(
                    width: 240,
                    height: 160,
                    margin: EdgeInsets.only(
                        left:
                            fileName == promotionImageFileNames.first ? 24 : 10,
                        right:
                            fileName == promotionImageFileNames.last ? 24 : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/$fileName'),
                        fit: BoxFit.cover,
                      ),
                    )),
              )
              .toList(),
        ),
      )
    ];
