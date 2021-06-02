//
//  ViewController.swift
//  practiceScrollView
//
//  Created by kudo koki on 2021/06/02.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    // キーボード出現によるスクロール量
    var scrollByKeyboard : CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        
        // notification
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        print("キーボード表示")
        
        // キーボードの大きさ取得
        let keyboardFrame: CGRect = (notification?.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // キーボードの上にテキストフィールドが来るようなスクロール移動量を算出
        self.scrollByKeyboard = keyboardFrame.size.height - (self.view.frame.height - self.textField.frame.maxY)
        let affine = CGAffineTransform.init(translationX: 0.0, y: -self.scrollByKeyboard)
        
        // アニメーションでスクロール実行
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.view.transform = affine
                       },
                       completion: nil)
        
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        print("キーボード非表示")
        
        // 戻すためのスクロール量
        let affine = CGAffineTransform.init(translationX: 0.0, y: 0.0)
        
        // スクロール
        UIView.animate(withDuration: 0.3,
                       animations: { self.view.transform = affine },
                       completion: { (true) in self.scrollByKeyboard = 0.0 }
        )
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("テキストフィールドがタップされた")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("リターンーが押された")
        return true
    }
}

