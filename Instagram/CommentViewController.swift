//
//  CommentViewController.swift
//  Instagram
//
//  Created by 有村卓馬 on 2020/10/03.
//  Copyright © 2020 takuma.arimura. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    var postData: PostData!
    @IBAction func commentPostButton(_ sender: Any) {
        
        // コメントデータの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        // FireStoreにコメントデータを保存する
        let comment = "\(Auth.auth().currentUser!.displayName!) : \(String(describing: commentTextField.text!))"
        let updateValue = FieldValue.arrayUnion([comment])
        
        postRef.updateData(["comments": updateValue])
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func commentCancelButton(_ sender: Any) {
        
        // 加工画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
