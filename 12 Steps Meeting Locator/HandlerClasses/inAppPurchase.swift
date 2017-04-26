//
//  inAppPurchase.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 13/07/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import StoreKit

let ProductId = "com.12StepLocator.YearlySubscription"
//let PRODUCTID = "com.hypnosis.hypnosisApp.FullStream"

private let singleObject = inAppPurchase()

class inAppPurchase: NSObject ,SKProductsRequestDelegate, SKPaymentTransactionObserver {
   
    

    
    
    
    let productIdentifiers = Set([ProductId])
    var product: SKProduct?
    var productsArray = Array<SKProduct>()
    
    
    
    
class var sharedInstance: inAppPurchase
{
        return singleObject
}
    
    
    
    func initialize()
    {
        SKPaymentQueue.default().add(self)
        requestProductData()
    }
    
    
    
    
    
    
    func requestProductData()
    {
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers: self.productIdentifiers as Set<String>)
//            let request = SKProductsRequest(productIdentifiers:
//                self.productIdentifiers as Set<String>)
            request.delegate = self
            request.start()
        } else {
            var alert : UIAlertController
            if #available(iOS 8.0, *) {
                alert = UIAlertController(title: "In-App Purchases Not Enabled", message: "Please enable In App Purchase in Settings", preferredStyle: UIAlertControllerStyle.alert)
               
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { alertAction in
                    alert.dismiss(animated: true, completion: nil)
                    
                    let url: URL? = URL(string: UIApplicationOpenSettingsURLString)
                    if url != nil
                    {
                        UIApplication.shared.openURL(url!)
                    }
                    
                }))
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { alertAction in
                    alert.dismiss(animated: true, completion: nil)
                }))
               // self.presentViewController(alert, animated: true, completion: nil)
                
                
                
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    func productsRequest(_ request: SKProductsRequest!, didReceive response: SKProductsResponse!) {
        
        var products = response.products
        
        if (products.count != 0) {
            for i in 0 ..< products.count
            {
                self.product = products[i] as? SKProduct
                self.productsArray.append(product!)
            }
            //self.tableView.reloadData()
        } else {
           // println("No products found")
        }
        
        products = [response.invalidProductIdentifiers as! SKProduct]
        
        for product in products
        {
           // println("Product not found: \(product)")
        }
    }
    
    func buyProduct(_ sender: UIButton) {
        let payment = SKPayment(product: productsArray[sender.tag])
        SKPaymentQueue.default().add(payment)
    }
    
//    func paymentQueue(_ queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
//        
//        
//    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case SKPaymentTransactionState.purchased:
                //println("Transaction Approved")
                // println("Product Identifier: \(transaction.payment.productIdentifier)")
                self.deliverProduct(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case SKPaymentTransactionState.failed:
                //println("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    
    func deliverProduct(_ transaction:SKPaymentTransaction) {
        
        if transaction.payment.productIdentifier == ProductId
        {
           // println("Consumable Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == ProductId
        {
            //println("Non-Consumable Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == ProductId
        {
            //println("Auto-Renewable Subscription Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == ProductId
        {
           // println("Free Subscription Product Purchased")
            // Unlock Feature
        }
        else if transaction.payment.productIdentifier == ProductId
        {
            //println("Non-Renewing Subscription Product Purchased")
            // Unlock Feature
        }
    }
    
    func restorePurchases(_ sender: UIButton) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
       // println("Transactions Restored")
        
//        var purchasedItemIDS = []
        for transaction:SKPaymentTransaction in queue.transactions {
            
            if transaction.payment.productIdentifier == ProductId
            {
              //  println("Consumable Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == ProductId
            {
                //println("Non-Consumable Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == ProductId
            {
              //  println("Auto-Renewable Subscription Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == ProductId
            {
               // println("Free Subscription Product Purchased")
                // Unlock Feature
            }
            else if transaction.payment.productIdentifier == ProductId
            {
               // println("Non-Renewing Subscription Product Purchased")
                // Unlock Feature
            }
        }
        
        let alert = UIAlertView(title: "Thank You", message: "Your purchase(s) were restored.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }

    
    
    
    
   
}









