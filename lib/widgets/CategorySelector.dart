import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  // CategorySelector({Key key}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['assets/images/clothes.png', 'assets/images/clothes.png', 'assets/images/clothes.png', 'assets/images/clothes.png'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyButton(),
          MyButton(),
          MyButton(),
          MyButton(),
        ],
        
      ),
    );
  }
}


class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        final snackBar = SnackBar(content: 
          TextField(
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Book Name',
              ),
            ),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset('assets/images/clothes.png'),
      ),
    );
  }
}



// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // The GestureDetector wraps the button.
//     return GestureDetector(
//       // When the child is tapped, show a snackbar.
//       onTap: () {
//         final snackBar = SnackBar(content: Text("Tap"));

//         Scaffold.of(context).showSnackBar(snackBar);
//       },
//       // The custom button
//       child: Container(
//         padding: EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: Theme.of(context).buttonColor,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Text('My Button'),
//       ),
//     );
//   }
// }

// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // The GestureDetector wraps the button.
//     return GestureDetector(
//       // When the child is tapped, show a snackbar.
//       onTap: () {
//         final snackBar = SnackBar(content: Text("Tap"));

//         Scaffold.of(context).showSnackBar(snackBar);
//       },
//       // The custom button
//       child: Container(
//         padding: EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: Theme.of(context).buttonColor,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Text('My Button'),
//       ),
//     );
//   }
// }

// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // The GestureDetector wraps the button.
//     return GestureDetector(
//       // When the child is tapped, show a snackbar.
//       onTap: () {
//         final snackBar = SnackBar(content: Text("Tap"));

//         Scaffold.of(context).showSnackBar(snackBar);
//       },
//       // The custom button
//       child: Container(
//         padding: EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: Theme.of(context).buttonColor,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Text('My Button'),
//       ),
//     );
//   }
// }