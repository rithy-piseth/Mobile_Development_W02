import 'package:flutter/material.dart';
import 'package:login/1%20-%20START%20CODE/data/repositories/scores_repository.dart';
import 'package:login/1%20-%20START%20CODE/data/services/auth_service.dart';

import '../model/score.dart';

class ScoresScreen extends StatefulWidget {
  const ScoresScreen({super.key});

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  List<Score>? scores;
  String? error;

  @override
  void initState() {
    super.initState();

    fetchSCores();
  }

  void fetchSCores() async {
    // Ask the ScoresRepository instance to fetch the scores
    scores = await ScoresRepository.instance.getSCores();
    setState(() {});
    // if succes, update the scores list and refresh
    if (scores == null) {
      setState(() {
        error = "failed to fetch score";
      });
    }
    // If failure, update the error and refresh
  }

  String? get userName {
    // Ask the AuthenticationService instance the current user nale (if any)
    if (AuthenticationService.instance.session?.user.name != null) {
      return AuthenticationService.instance.session?.user.name;
    }

    return null;
  }

  Widget get content {
    // If scores list => dispaly the list using the ScoreTile
    
    // if error, dispaly the erro in red, centered

    // otherwise, we disaply the  CircularProgressIndicator
    return CircularProgressIndicator();
  }

  String get welcomeLabel => "Welcome ${userName != null ? userName! : ""} !";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(welcomeLabel)),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(20.0), child: content),
      ),
    );
  }
}

class ScoreTile extends StatelessWidget {
  const ScoreTile({super.key, required this.score});

  final Score score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(title: Text(score.title)),
    );
  }
}
