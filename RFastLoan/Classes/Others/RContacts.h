//
//  RContacts.h
//  RFastLoan
//
//  Created by RPK on 2018/12/18.
//  Copyright © 2018 RPK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RContacts : NSObject

// <#描述#>
@property(nonatomic, strong) NSMutableArray *contactDatas;
- (void)requestContactAuthorAfterSystemVersion9;

@end

NS_ASSUME_NONNULL_END
