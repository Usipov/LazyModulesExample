//
//  LazyModulesLoader.m
//  DI
//
//  Created by Timur Yusipov on 22/04/2019.
//  Copyright © 2019 Avito. All rights reserved.
//

#import "LazyModulesLoader.h"

@implementation LazyModulesLoader
- (nullable id)instantiateClassNamed:(NSString *)className
                       inModuleNamed:(NSString *)moduleName
{
    // ModuleName.ClassName
    NSString *fullClassName = [NSString stringWithFormat:@"%@.%@", moduleName, className];
    
    id result = [self instantiateClassFullyNamed: fullClassName];
    
    // Module is already loaded into memory
    if (result != nil) {
        return result;
    }
        
    // Module is not loaded into memory. Try to load it
    NSError *__autoreleasing error = nil;
    if ([self loadDynamicFrameworkModule: moduleName error: &error]) {
        // Try again
        result = [self instantiateClassFullyNamed: fullClassName];        
    } else {
        NSLog(@"%@", error);
    }
    
    return result;
}

- (BOOL)loadDynamicFrameworkModule:(NSString *)frameworkName error:(NSError *__autoreleasing *)error {
    NSParameterAssert(*error == nil);
    NSString *frameworksPath = [[NSBundle mainBundle] privateFrameworksPath];
    NSString *frameworkPath = [NSString stringWithFormat:@"%@/%@.framework", frameworksPath, frameworkName];
    NSBundle *bundle = [NSBundle bundleWithPath:frameworkPath];
    return [bundle loadAndReturnError:error];
}

- (nullable id)instantiateClassFullyNamed:(NSString *)fullClassName {
    Class class = NSClassFromString(fullClassName);
    return [[class alloc] init];
}
@end
