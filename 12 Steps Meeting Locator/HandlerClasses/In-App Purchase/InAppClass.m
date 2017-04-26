//
//  RecipeProducts.m
//  BPDown
//
//  Created by ml2-1 on 11/14/13.
//  Copyright (c) 2013 TheTiger. All rights reserved.
//

#import "InAppClass.h"
#import "SVProgressHUD.h"

//#define PRODUCTID @"com.hypnosis.hypnosisApp.consumableSingleStream"
//#define PRODUCTID @"com.hypnosis.hypnosisApp.FullStream"
//#define PRODUCTID @ "com.iAppTechnologies.PDFConversionPro.AddAnnotation"
//#define PRODUCTID @"com.12StepLocator.YearlySubscription"
#define PRODUCTID @"com.12StepLocator.YearlySubscription"



#define ShowTransactionAlert(TITLE, MESSAGE) [[[UIAlertView alloc] initWithTitle:TITLE message:MESSAGE delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]


@interface inAppClass () <SKProductsRequestDelegate ,SKPaymentTransactionObserver>
{
    RequestProductsCompletionHandler _completionHandler;
    SKProductsRequest *_productsRequest;
    NSSet *productIdentifiers;
}
@property(nonatomic,strong)NSSet *productIdentifiers;
-(void)addProductToPurchasedList:(NSString *)productIdentifier;

@end

@implementation inAppClass
@synthesize delegate = _delegate;
@synthesize products = _products;
@synthesize product_Identifier = _product_Identifier;
static inAppClass *productsHalper = nil;
//static NSSet *productIdentifiers = nil;
static NSMutableArray *purchsaedProducts = nil;

+(inAppClass *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        productsHalper = [[inAppClass alloc] init];
    });
    
    return productsHalper;
}

-(void)initialize
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
   // productIdentifiers = [NSSet setWithObjects:self.product_Identifier, nil];
  //  productIdentifiers = [NSSet setWithObjects:@"com.ilyakuznetsov.phoenix1.WaterMark",@"com.ilyakuznetsov.phoenix1.comics",@"com.ilyakuznetsov.phoenix1.food,com.ilyakuznetsov.phoenix1.atm",@"com.ilyakuznetsov.phoenix1.hats",nil];
   
    
    productIdentifiers = [NSSet setWithObjects:PRODUCTID,nil];
    
//    productIdentifiers = [NSSet setWithObjects:ANNOTATION_PRODUCT_ID,FONTS_PRODUCT_ID,UNLOCKALL_PRODUCT_ID,REMOVE_ADS,nil];
    
    NSArray *productIds = [productIdentifiers allObjects];

    purchsaedProducts = [[NSMutableArray alloc] init];
    // Check for previously purchased products
    for (NSString *productId in productIds)
    {
        BOOL purchsed = [[NSUserDefaults standardUserDefaults] boolForKey:productId];
        if (purchsed) {
            [purchsaedProducts addObject:productId];
        }
    }

}

-(void)addProductToPurchasedList:(NSString *)productIdentifier
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [purchsaedProducts addObject:productIdentifier];
}

-(BOOL)productIsAlreadyPurchased:(NSString *)productIdentifier
{
    return [purchsaedProducts containsObject:productIdentifier];
}

-(void)buyProduct:(SKProduct *)product
{
    
    //cha
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];

        // UI UPDATION 1
    });
   }

#pragma mark - Request For Products
-(void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler
{
    _completionHandler = [completionHandler copy];
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
//    for(SKProduct *product in response.products)
//    {
//       // NSLog(@".....%@",product.price);
//        
//    }

   // NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    self.products = response.products;
    for (SKProduct *product in response.products) {
       // NSLog(@"Purchase request for: %@", product.productIdentifier);
    }

   // NSLog(@"the recieved products....%@",self.products);
    if ([self.products count]==0) {
        _completionHandler (NO, self.products);
        _completionHandler = nil;
        self.products = nil;
    }
    else
    {
      _completionHandler (YES, self.products);
      _completionHandler = nil;
    }
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
   // NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler (NO, nil);
    _completionHandler = nil;
}

#pragma mark - Payment Methods
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self purchaseTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self purchasingTransaction:transaction];
                break;
            
                
            default:
                break;
        }
    }
}

-(void)purchaseTransaction:(SKPaymentTransaction *)transaction
{
    
    [self addProductToPurchasedList:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
  //  ShowTransactionAlert(@"", NSLocalizedString(@"You have purchased paid version successfully.\nThank you for purchasing!", nil));
    if ([self.delegate respondsToSelector:@selector(didFinishWithTransaction:)]) {

        [self.delegate didFinishWithTransaction:transaction];
    }
    
    
    
}

-(void)purchasingTransaction:(SKPaymentTransaction *)transaction
{
    
}

-(void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code == SKErrorPaymentCancelled)
    {
       // NSLog(@"Transaction Cancelled");
        ShowTransactionAlert(@"", NSLocalizedString(@"Transaction cancelled!", nil));
        if ([self.delegate respondsToSelector:@selector(didFailWithError:transaction:)])
        {
            [self.delegate didFailWithError:nil transaction:transaction];
        }
    }
    else
    {
      //  NSLog(@"Transaction Error: %@", [transaction.error localizedDescription]);
        NSString *message = [NSString stringWithFormat:@"%@",[transaction.error localizedDescription]];
        ShowTransactionAlert(@"", message);
        if ([self.delegate respondsToSelector:@selector(didFailWithError:transaction:)])
        {
            [self.delegate didFailWithError:transaction.error transaction:transaction];
        }
    }
    
    [SVProgressHUD dismiss];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self addProductToPurchasedList:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


@end
