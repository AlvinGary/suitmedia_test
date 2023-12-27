part of 'pages.dart';

class SecondScreen extends StatefulWidget {
  final String name;
  const SecondScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String selectedUserName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          // This aligns the welcome text to the top left corner
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome\n', // this adds a line break
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    TextSpan(
                      text: '${widget.name}', // this is the second text span
                      style: TextStyle(
                          fontSize: 27,
                          // fontFamily: ,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // This creates a spacer that fills the vertical space between the texts and the button
          Spacer(),
          // This aligns the selected user name text to the center of the screen

          Align(
            alignment: Alignment.center,
            child: Text(
              selectedUserName.isEmpty
                  ? 'Selected User Name'
                  : '$selectedUserName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // This creates a spacer that fills the vertical space between the text and the button
          Spacer(),
          // This aligns the choose a user button to the bottom center of the screen
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdScreen(),
                    ),
                  );
                  setState(() {
                    selectedUserName = result ?? '';
                  });
                },
                child: Text('Choose a User'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16),
                  minimumSize: Size(330, 40),
                  backgroundColor: Color.fromARGB(1, 43, 99, 123),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
