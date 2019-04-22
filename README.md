## LazyModulesExample

This demo project is here for educational purposes and contains mvp code, that can be vastly improved.

It demonstrates the following features:

- Lazy modules loading
- Modules merging

Both of them show you the ways of reducing the dynamic libaries count, which `dyld` loads during the application start.

Another solution is to turn all modules from dynamic frameworks into static libraries, but this is not that fun =).

Build the project and check the contents of your `LazyModulesExample.app/Frameworks` folder.

You will see `Feature1.framework`, `Feature2.framework` and `MergedCore.framework` (and probably several `libswift.dylib`s, depending on versions of your `Xcode` and target `iOS`).

During the application start only system libraries and `MergedCore.framework` will be loaded into memory. `Feature1.framework` and `Feature2.framework` will be loaded on demand at runtime (i.e. lazily).


### Lazy modules loading

1. Launch the app and tap "LOAD FEATURE 1" or "LOAD FEATURE 2" button.

2. Check the console logs. You will see something like
```
!!!
  Will load Feature1 if it is not loaded yet.
  See dyld logs in the console.
  ...
!!!
```
```
dyld: loaded: /Users/username/Library/Developer/Xcode/DerivedData/LazyModulesExample-giiydmraztexwgcipbutixergqns/Build/Products/Debug-iphonesimulator/Feature1.framework/Feature1
```
```
In Feature1. Printing from class named: Protocol1Impl
```

What this means, is that dynamic linker (`dyld`) loaded a framework from the disk into memory.
See `LazyModulesLoader.m` for some implementation details.

3. If you did not see what was mentioned above, then make sure 'Dynamic Library Loads' is enabled in 'Scheme -> Run -> Diagnostics', 
or pass 'DYLD_PRINT_LIBRRARIES' environment variable in 'Scheme -> Run -> Arguments -> Eviromnent Variables'.


### Modules hierarchy

1. `Feature1` - lazily loaded module.
1. `Feature2` - lazily loaded module.
1. `Interfaces` - a mediator module to allow communication between feature modules 
(features do not depend on each other, they depend on `Interfaces`).
1. `DI` - dependency injection module. Also implements lazy loading of other modules.
1. `Footprints` - module to feed `DI` with information about which lazy module to load in response on a `resolve()` request.
1. `MergedCore` - module in which we merge `DI`, `Interfaces` and `Footprints`.


### Modules merging

Modules merging is based on the technique described in [Amimono cocoapods plugin](https://github.com/Ruenzuo/cocoapods-amimono).

We merge `DI`, `Interfaces` and `Footprints` into `MergedCore`.

1. See `MergedCore.xcconfig` with its `-filelist` flag passed to the static linker (`ld`).
1. See `Create filelist per architecture` build phase of `MergedCore` target to understand how this filelist gets filled.
1. See `Check for dublicated symbols absence` build phase of `LazyModulesExample` target to understand how we make sure no dublicated symbols get bundled in the application.
This may happen if you accidentally break the project via copying `DI.framework` into the `LazyModulesExample.app/Frameworks` folder
and linking `LazyModulesExample.app/LazyModulesExample` against `DI.framework/DI` while still linking against `MergedCore.framework/MergedCore`.
