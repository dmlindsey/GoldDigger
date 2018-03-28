//
//  ViewController.swift
//  Gold Digger
//
//  Created by Dean Lindsey on 27/03/2018.
//  Copyright © 2018 Dean Lindsey. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var activeProduct : SKProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SKPaymentQueue.default().add(self)
        
        let productIds : Set<String> = ["uk.org.coolamber.GoldDigger.Gold"]
        let prodRequest = SKProductsRequest(productIdentifiers: productIds)
        prodRequest.delegate = self
        prodRequest.start()
    }
    
    @IBAction func buyTapped(_ sender: Any) {
        
        if let activeProduct = activeProduct {
            print("Buying....")
            let payment = SKPayment(product: activeProduct)
            SKPaymentQueue.default().add(payment)
        }
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch (transaction.transactionState) {
                
            case .purchased :
                SKPaymentQueue.default().finishTransaction(transaction)
                resultLabel.text = "YOU GOT SOME GOLD!"
            case .failed :
                SKPaymentQueue.default().finishTransaction(transaction)
                resultLabel.text = "Something went wrong :-("
            default :
                break
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        print("Loaded Products")
        
        for product in response.products {
            
            print("Product: \(product.productIdentifier) \(product.localizedTitle) \(product.price.floatValue)")
            
            nameLabel.text = product.localizedTitle
            activeProduct = product
        }
    }
    
    
    
}

