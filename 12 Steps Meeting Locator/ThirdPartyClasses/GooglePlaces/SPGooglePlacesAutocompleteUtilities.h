//
//  SPGooglePlacesAutocompleteUtilities.h
//  SPGooglePlacesAutocomplete
//
//  Created by Stephen Poletto on 7/18/12.
//  Copyright (c) 2012 Stephen Poletto. All rights reserved.
//
//AIzaSyByLuOa1XjAabTy93KLbZCjCYuv-pA-udo
//#define kGoogleAPIKey @"AIzaSyCu3RgLlDtHgw3ujBCQdL63m40iW5HbcxU"  //Ios Key
//#define kGoogleAPIKey @"AIzaSyByLuOa1XjAabTy93KLbZCjCYuv-pA-udo"  //Browser Key
//#define kGoogleAPIKey @"AIzaSyDsG4sAwYFACmIzbuWLgJyVm96tmgNBLnQ"  //


#define kGoogleAPIKey @"AIzaSyBkY7jJwVsv2HlM-8QxD54Z4L_GPXBykGo" // Server Key

//#define kGoogleAPIKey @"AIzaSyCl72yvTpELfdPsUMlh60YhkYoaXf5Y85s" // Server Key
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//#define kGoogleAPIKey @"AIzaSyCcENFI6D67iZk9UmW0rGeL55g3AK9zIFM"
#define kGoogleAPINSErrorCode 42

@class CLPlacemark;

typedef enum {
    SPPlaceTypeGeocode = 0,
    SPPlaceTypeEstablishment
} SPGooglePlacesAutocompletePlaceType;

typedef void (^SPGooglePlacesPlacemarkResultBlock)(CLPlacemark *placemark, NSString *addressString, NSError *error);
typedef void (^SPGooglePlacesAutocompleteResultBlock)(NSArray *places, NSError *error);
typedef void (^SPGooglePlacesPlaceDetailResultBlock)(NSDictionary *placeDictionary, NSError *error);

extern SPGooglePlacesAutocompletePlaceType SPPlaceTypeFromDictionary(NSDictionary *placeDictionary);
extern NSString *SPBooleanStringForBool(BOOL boolean);
extern NSString *SPPlaceTypeStringForPlaceType(SPGooglePlacesAutocompletePlaceType type);
extern BOOL SPEnsureGoogleAPIKey();
extern void SPPresentAlertViewWithErrorAndTitle(NSError *error, NSString *title);
extern BOOL SPIsEmptyString(NSString *string);

@interface NSArray(SPFoundationAdditions)
- (id)onlyObject;
@end
