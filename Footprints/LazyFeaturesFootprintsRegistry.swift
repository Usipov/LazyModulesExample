import DI

public final class LazyFeaturesFootprintsRegistry {
    public init() {}
    
    public func registerFeatureFootprints(in container: DIContainer) {
        let feature1Footprint = LazyFeatureFootprint(
            lazilyRegisteredTypes: ["Protocol1"],
            moduleName: "Feature1",
            lazyDIFactoryClassName: "Feature1LazyDIFactory"
        )
        
        let feature2Footprint = LazyFeatureFootprint(
            lazilyRegisteredTypes: ["Protocol2"],
            moduleName: "Feature2",
            lazyDIFactoryClassName: "Feature2LazyDIFactory"
        )
        
        container.addLazyDIFactoryInfoProvider(feature1Footprint)
        container.addLazyDIFactoryInfoProvider(feature2Footprint)
    }
}
