//
//  TimelineViewController.swift
//  TwitterTrend
//
//  Created by Kazuma Hatada on 2019/08/27.
//  Copyright © 2019 Kazuma Hatada. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // テーブル表示用のデータソース
    var tweets: [Tweet] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // delegateの指定を自分自身（self = TimelineViewController）に設定
        tableView.delegate = self
        
        // dataSourceの指定を自分自身(self = TimelineViewController)に設定
        tableView.dataSource = self
        
/*
        // ダミーデータの生成
        let fileURL = "http://www.ksky.ne.jp/~yamama/jpggpsmap/sample/Hijiribashi.JPG"
        let user = User(id: "1", screenName: "scrtest", name: "テスト", profileImageURL: fileURL)
        let tweet = Tweet(id: "01", text: "Twitterクライアント作成なう", user: user)
        
        let tweets = [tweet]
        self.tweets = tweets
        
        // tableViewのリロード
        print("aaa")
        tableView.reloadData()
        print("bbb")
*/
        LoginCommunicator().login() { isSuccess in
            switch isSuccess {
            case false:
                print("ログイン失敗")
            case true:
                print("ログイン成功")
                
                TwitterCommunicator().getTimeline() { [weak self] data, error in
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    print(data!)
                    
                    let timelineParser = TimelineParser()
                    let tweets = timelineParser.parse(data: data!)
                    
                    print(tweets)
                    
                    self?.tweets = tweets
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimelineViewController: UITableViewDelegate {
    
    // cellがタップされたのを検知したときに実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされたよ！")
    }
    
    // セルの見積もりの高さを指定する処理
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // セルの高さ指定をする処理
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // UITableViewCellの高さを自動で取得する値
        print("\(UITableView.automaticDimension)")
        return UITableView.automaticDimension
    }
}

extension TimelineViewController: UITableViewDataSource {
    // 何個のcellを生成するかを設定する関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // tweetsの配列内の要素数分を指定
        print("tweets.count[\(tweets.count)]")
        return tweets.count
    }
    
    // 描画するcellを設定する関数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TweetTableViewCellを表示したいので、TweetTableViewCellを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
        
        // TweetTableViewCellの描画内容となるtweetを渡す
        cell.fill(tweet: tweets[indexPath.row])

        return cell
    }
}

