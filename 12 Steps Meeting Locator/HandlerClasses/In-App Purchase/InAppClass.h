//
//  RecipeProducts.h
//  BPDown
//
//  Created by ml2-1 on 11/14/13.
//  Copyright (c) 2013 TheTiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

//#define Product_Identifier @"com.12StepLocator.YearlySubscription"

@protocol inAppProductsDelegate <NSObject>
@optional
-(void)didFinishWithTransaction:(SKPaymentTransaction *)transaction;
-(void)didFailWithError:(NSError *)error transaction:(SKPaymentTransaction *)transaction;
-(void)failedTransaction:(SKPaymentTransaction *)transaction;
@end

@interface inAppClass : NSObject

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray *products);

@property (nonatomic, assign) id <inAppProductsDelegate> delegate;
@property (strong, nonatomic) NSArray *products;
@property (strong,nonatomic) NSString *product_Identifier;

+(inAppClass *)sharedInstance;
-(void)initialize;

-(void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
-(BOOL)productIsAlreadyPurchased:(NSString *)productIdentifier;
-(void)buyProduct:(SKProduct *)product;

@end
