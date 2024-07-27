import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wordgame/helper_function.dart';
import 'package:wordgame/huddleprovider.dart';
import 'package:wordgame/keyboard_view.dart';
import 'package:wordgame/wordle.dart';
import 'package:wordgame/wordle_view.dart';

class WordHuddlePage extends StatefulWidget {
  const WordHuddlePage({super.key});

  @override
  State<WordHuddlePage> createState() => _WordHuddlePageState();
}

class _WordHuddlePageState extends State<WordHuddlePage> {

  @override
  void didChangeDependencies() {
    Provider.of<huddleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Huddle"),
      ),
      body: Center(child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: Consumer<huddleProvider>(
                builder: (context, provider, child) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4
                    ), 
                    itemCount: provider.huddleBoard.length,
                  itemBuilder: (context, index){
                    final wordle = provider.huddleBoard[index];
                    return WordleView(wordle: wordle);
              
                  }),
              ),
            ),
          ),
          Consumer<huddleProvider>
          (builder: (context, provider, child) => 
          KeyboardView(
            excludedletters: provider.excludedletters,
            onPressed: (value){
              provider.inputLetters(value);
            },
          ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Consumer<huddleProvider>
            (builder: (context, provider, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    provider.deleteLetter();
                  }, 
                  child: Text("DELETE"),
                  ),
                  ElevatedButton(
                  onPressed: (){
                    if(!provider.isAValiWord){
                      showMsg(context,'Not a word in the dictionary');
                      return;
                    }

                    if(provider.shouldCheckForAnswer){
                      provider.checkAnswer();
                    }

                    if(provider.win){
                      showResults(
                        context: context, 
                        title: "YOU WIN!!!", 
                        body: "THE WORD IS ${provider.targetWord}", 
                        onPlayAgain: (){
                          Navigator.pop(context);
                          provider.reset();
                        }, 
                        onCancel: (){
                          Navigator.pop(context);
                        }
                        );
                    }else if(provider.noAttemptLeft){
                      showResults(
                        context: context, 
                        title: 'You Lost!!', 
                        body: 'The word was ${provider.targetWord}', 
                        onPlayAgain: (){
                          Navigator.pop(context);
                          provider.reset();
                        }, 
                        onCancel: (){
                          Navigator.pop(context);
                        }
                        );
                    }
                  }, 
                  child: Text("SUBMIT"),
                  ),
              ],
            ),
            ),
            )
        ],
      ),
      ),
    );
  }
}