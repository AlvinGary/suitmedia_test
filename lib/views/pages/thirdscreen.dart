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
    getUsers();
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
        child: ListView.separated(
          // this is what you need
          itemCount: users.length + 1,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 2); // this is the separator widget
          },
          itemBuilder: (BuildContext context, int index) {
            if (index == users.length) {
              return isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox();
            }

            final user = users[index];
            return Card(
              // this is the item widget
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
            );
          },
        ),
      ),
    );
  }
}
