//
//  ViewController.swift
//  VaultSDKExample
//
//  Created by Fang-Pen Lin on 11/23/16.
//  Copyright © 2016 Very Good Security. All rights reserved.
//

import UIKit

import VaultSDK

class ViewController: UIViewController {

    @IBOutlet weak var senstiveDataField: UITextField!
    @IBOutlet weak var tokenResultField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tokenizeButtonTapped(_ sender: Any) {
        let api = VaultAPI(
            baseURL: URL(string: "https://demo.sandbox.verygoodvault.com")!,
            publishableKey: "demo-user"
        )
        api.createToken(
            payload: senstiveDataField.text!,
            failure: { error in
                print("Error: \(error)")
                DispatchQueue.main.async {
                    self.tokenResultField.text = "Error: \(error)"
                }
            },
            success: { [unowned self] token in
                print("Token: \(token)")
                DispatchQueue.main.async {
                    self.tokenResultField.text = token["id"] as? String
                }
            }
        )
    }

}
