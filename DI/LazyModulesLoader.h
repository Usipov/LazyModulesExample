//
//  LazyModulesLoader.h
//  DI
//
//  Created by Timur Yusipov on 22/04/2019.
//  Copyright © 2019 Avito. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LazyModulesLoader : NSObject
- (nullable id)instantiateClassNamed:(nonnull NSString *)className
                       inModuleNamed:(nonnull NSString *)moduleName
NS_SWIFT_NAME(instantiateClass(named:in:));
@end

NS_ASSUME_NONNULL_END
