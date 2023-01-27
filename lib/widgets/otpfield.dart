import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpField extends StatelessWidget {
  const OtpField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        height: 60,
        width: 56,
        child: TextFormField(
          cursorColor: Color.fromARGB(255, 22, 2, 66),
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
          onChanged: (value) {
            if (value.length == 1 ) {
              FocusScope.of(context).nextFocus();
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          //  style: Theme.of(context).textTheme.headline6,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    );
  }
}
