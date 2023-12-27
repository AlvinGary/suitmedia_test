part of 'pages.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final ctrlName = TextEditingController();
  final ctrlSentence = TextEditingController();

  bool isPalindrome(String sentence) {
    String cleanSentence = sentence.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    return cleanSentence.toLowerCase() ==
        cleanSentence.toLowerCase().split('').reversed.join('');
  }

  void checkPalindrome() {
    String sentence = ctrlSentence.text;
    String message = isPalindrome(sentence) ? 'isPalindrome' : 'not palindrome';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlSentence.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 150,
              left: 30,
              right: 30,
              child: Column(
                children: [
                  Container(
                      child: Image(
                    image: AssetImage('assets/images/ic_photo.png'),
                  )),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 50,
                    width: 330,
                    child: TextField(
                      controller: ctrlName,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.person,
                          size: 25,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.bottom,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 330,
                    child: TextField(
                      controller: ctrlSentence,
                      decoration: InputDecoration(
                        hintText: 'Sentence',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.text_fields,
                          size: 25,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.bottom,
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: checkPalindrome,
                    child: Text('CHECK'),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 16),
                      minimumSize: Size(330, 45),
                      backgroundColor: Color.fromARGB(1, 43, 99, 123),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondScreen(
                            name: ctrlName.text,
                          ),
                        ),
                      );
                    },
                    child: Text('NEXT'),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 16),
                      minimumSize: Size(330, 45),
                      backgroundColor: Color.fromARGB(1, 43, 99, 123),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
