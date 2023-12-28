part of 'pages.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<dynamic> users = [];
  int page = 1;
  bool isLoading = false;

  Future<void> getUsers() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$page&per_page=10'),
    );
    final data = jsonDecode(response.body);
    setState(() {
      isLoading = false;
      users.addAll(data['data']);
      page++;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    controller.removeListener(_loadMore);
    super.dispose();
  }

  _loadMore() {
    if (controller.position.extentAfter < 300) {
      setState(() {
        page++;
      });
      getUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Third Screen'),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            users.clear();
            page = 1;
          });
          await getUsers();
        },
        child: ListView.builder(
          // this is what you need
          itemCount: users.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == users.length) {
              return isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox();
            }

            final user = users[index];
            return Padding(
              // this is what you need
              padding: EdgeInsets.all(2), // this is the padding value
              child: Card(
                // this is what you need
                elevation: 5.0, // this is the elevation value
                child: ListTile(
                  title: Text('${user['first_name']} ${user['last_name']}'),
                  subtitle: Text(user['email']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['avatar']),
                  ),
                  onTap: () {
                    Navigator.pop(
                        context, '${user['first_name']} ${user['last_name']}');
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
