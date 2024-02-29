import 'package:flutter/material.dart';

/// Statefullにして、ドラッグアンドドロップ(DnD)により選択アイテムなどのデータが変更されたときに再描画(SetState)する
class DndDemoView extends StatefulWidget {
  const DndDemoView({Key? key}) : super(key: key);

  @override
  State<DndDemoView> createState() => _DndDemoViewState();
}

class _DndDemoViewState extends State<DndDemoView> {
  /// DnDで扱いたいデータを定義
  /// 今回はStringにしているが、intでもWidgetでも良い
  List<String> selectedItem = ["","",""]; /// 選択したアイテム
  List<String> items = ["動かすもの1","動かすもの2","動かすもの3","動かすもの4","動かすもの5"]; /// 選択肢

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ドラッグアンドドロップ デモ"),
      ),

      /// 以下の2パターンで実装しているので、それぞれコメントアウトを外して確認してください
      // body: _body(),
      body: _body2(),
    );
  }

  Widget _body(){
    return Row(
      children: [
        Column(
          children: [
            /// ドロップスペースのWidget
            /// 扱うデータをStringと定義(intでもWidgetでも定義可)
            DragTarget<String>(
              /// builderにて描画する要素を指定
              builder: (context, acceptedData, rejectedData) {
                /// 何もドロップされていなければ単なるContainer
                /// ドロップされていればDraggableを入れる
                /// こうすることでドロップ済みの要素を再度ドラッグ出来る
                return (selectedItem[0] == "") ? Container(
                  color: Colors.grey.withOpacity(0.5),
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  child: const Text('ドロップ①'),
                ) : Draggable<String>(
                    data: selectedItem[0],
                    feedback: Material(
                      child: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        width: 300,
                        height: 50,
                        child: const Text("動かし中"),
                      ),
                    ),
                    child: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      width: 300,
                      height: 50,
                      child: Text(selectedItem[0]),
                    )
                );
              },
              /// ドロップされたときの処理
              onAccept: (data) {
                setState(() {
                  /// ドロップされたデータ(今回はString)を選択したアイテムとして登録
                  selectedItem[0] = data;
                });
              },

              /// DragTargetの範囲から離れたときの処理
              /// ドロップ済みの要素を取り外す処理
              onLeave: (data) {
                setState(() {
                  if(data != null){
                    /// 選択したアイテムを初期化
                    selectedItem[0] = "";
                  }
                });
              },
            ),

            const SizedBox(height: 20,),

            /// 以下のDragTargetでも、上と同じ処理を行う
            DragTarget<String>(
              builder: (context, acceptedData, rejectedData) {
                return (selectedItem[1] == "") ? Container(
                  color: Colors.grey.withOpacity(0.5),
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  child: const Text('ドロップ②'),
                ) : Draggable<String>(
                    data: selectedItem[1],
                    feedback: Material(
                      child: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        width: 300,
                        height: 50,
                        child: const Text("動かし中"),
                      ),
                    ),
                    child: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      width: 300,
                      height: 50,
                      child: Text(selectedItem[1]),
                    )
                );
              },
              onAccept: (data) {
                setState(() {
                  selectedItem[1] = data;
                });
              },
              onLeave: (data) {
                setState(() {
                  if(data != null){
                    selectedItem[1] = "";
                  }
                });
              },
            ),

            const SizedBox(height: 20,),

            DragTarget<String>( //ドラッグ中のWidgetを受け入れるためのWidget
              builder: (context, acceptedData, rejectedData) { //受け入れる範囲を表示するためのプロパティ
                return (selectedItem[2] == "") ? Container(
                  color: Colors.grey.withOpacity(0.5),
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  child: const Text('ドロップ③'),
                ) : Draggable<String>(
                    data: selectedItem[2],
                    feedback: Material(
                      child: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        width: 300,
                        height: 50,
                        child: const Text("動かし中"),
                      ),
                    ),
                    child: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      width: 300,
                      height: 50,
                      child: Text(selectedItem[2]),
                    )
                );
              },
              onAccept: (data) {
                setState(() {
                  selectedItem[2] = data;
                });
              },
              onLeave: (data) {
                setState(() {
                  if(data != null){
                    selectedItem[2] = "";
                  }
                });
              },
            ),
          ],
        ),
        SizedBox(width: 20,),

        /// ドラッグする要素を描画
        Column(
          children: draggableItems(),
        ),
      ],
    );
  }

  List<Widget> draggableItems(){
    List<Widget> returnItems = [];
    /// 選択肢のそれぞれについてWidgetを用意
    for(String item in items){
      if(!selectedItem.contains(item)){
        /// 未選択の場合はDraggableを用意
        returnItems.add(
            Draggable<String>(
                data: item,
                feedback: Material(
                  child: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.center,
                    width: 300,
                    height: 50,
                    child: const Text("動かし中"),
                  ),
                ),
                child: Container(
                  color: Colors.redAccent,
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  child: Text(item),
                )
            )
        );
      }else{
        /// 選択済みの場合は、同じ高さのSizedBoxを用意
        /// (選択済みをただ描画しないだけだと、DnD毎に選択肢の位置が変わってしまい、UXが悪い)
        returnItems.add(
          const SizedBox(
            width: 300,
            height: 50,
          )
        );
      }
      /// 余白を開ける
      returnItems.add(
          const SizedBox(
            height: 20,
          )
      );
    }
    return returnItems;
  }



  /** 以下の実装は別パターン **/

  Widget _body2(){
    return Row(
      children: [
        Column(
          children: [
            /// ドロップスペースのWidget
            /// 扱うデータをStringと定義(intでもWidgetでも定義可)
            DragTarget<String>(
              /// builderにて描画する要素を指定
              builder: (context, acceptedData, rejectedData) {
                /// 何もドロップされていなければ単なるContainer
                /// ドロップされていればDraggableを入れる
                /// こうすることでドロップ済みの要素を再度ドラッグ出来る
                return (selectedItem[0] == "") ? Container(
                  color: Colors.grey.withOpacity(0.5),
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  child: const Text('ドロップ①'),
                ) : Draggable<String>(
                    data: selectedItem[0],
                    feedback: Material(
                      child: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        width: 300,
                        height: 50,
                        child: const Text("動かし中"),
                      ),
                    ),
                    child: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      width: 300,
                      height: 50,
                      child: Text(selectedItem[0]),
                    )
                );
              },
              /// ドロップされたときの処理
              onAccept: (data) {
                if(selectedItem.contains(data)){
                  int index = selectedItem.indexOf(data);
                  setState(() {
                    selectedItem[index] = "";
                    selectedItem[0] = data; /// ドロップされたデータ(今回はString)を選択したアイテムとして登録
                  });
                }else{
                  setState(() {
                    selectedItem[0] = data; /// ドロップされたデータ(今回はString)を選択したアイテムとして登録
                  });
                }
              },
            ),

            const SizedBox(height: 20,),

            /// 以下のDragTargetでも、上と同じ処理を行う
            DragTarget<String>(
              builder: (context, acceptedData, rejectedData) {
                return (selectedItem[1] == "") ? Container(
                  color: Colors.grey.withOpacity(0.5),
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  child: const Text('ドロップ②'),
                ) : Draggable<String>(
                    data: selectedItem[1],
                    feedback: Material(
                      child: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        width: 300,
                        height: 50,
                        child: const Text("動かし中"),
                      ),
                    ),
                    child: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      width: 300,
                      height: 50,
                      child: Text(selectedItem[1]),
                    )
                );
              },
              onAccept: (data) {
                if(selectedItem.contains(data)){
                  int index = selectedItem.indexOf(data);
                  setState(() {
                    selectedItem[index] = "";
                    selectedItem[1] = data; /// ドロップされたデータ(今回はString)を選択したアイテムとして登録
                  });
                }else{
                  setState(() {
                    selectedItem[1] = data; /// ドロップされたデータ(今回はString)を選択したアイテムとして登録
                  });
                }
              },
            ),

            const SizedBox(height: 20,),

            DragTarget<String>( //ドラッグ中のWidgetを受け入れるためのWidget
              builder: (context, acceptedData, rejectedData) { //受け入れる範囲を表示するためのプロパティ
                return (selectedItem[2] == "") ? Container(
                  color: Colors.grey.withOpacity(0.5),
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  child: const Text('ドロップ③'),
                ) : Draggable<String>(
                    data: selectedItem[2],
                    feedback: Material(
                      child: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.center,
                        width: 300,
                        height: 50,
                        child: const Text("動かし中"),
                      ),
                    ),
                    child: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      width: 300,
                      height: 50,
                      child: Text(selectedItem[2]),
                    )
                );
              },
              onAccept: (data) {
                if(selectedItem.contains(data)){
                  int index = selectedItem.indexOf(data);
                  setState(() {
                    selectedItem[index] = "";
                    selectedItem[2] = data; /// ドロップされたデータ(今回はString)を選択したアイテムとして登録
                  });
                }else{
                  setState(() {
                    selectedItem[2] = data; /// ドロップされたデータ(今回はString)を選択したアイテムとして登録
                  });
                }
              },
            ),
          ],
        ),
        SizedBox(width: 20,),

        /// ドラッグする要素全体を「ドロップ可能な領域」とする
        DragTarget<String>(
          builder: (context, acceptedData, rejectedData) {
            /// ドラッグする要素を描画
            return Column(
              children: draggableItems(),
            );
          },

          /// この領域内にドロップされたもので、選択済みの要素ならその要素を取り外す
          onAccept: (data) {
            if(selectedItem.contains(data)){
              int index = selectedItem.indexOf(data);
              setState(() {
                selectedItem[index] = "";
              });
            }
          },
        ),
      ],
    );
  }


}
