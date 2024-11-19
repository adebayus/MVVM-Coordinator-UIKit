#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"example.UIKitCoordinator";

/// The "background_primary" asset catalog color resource.
static NSString * const ACColorNameBackgroundPrimary AC_SWIFT_PRIVATE = @"background_primary";

/// The "background_primary_disabled" asset catalog color resource.
static NSString * const ACColorNameBackgroundPrimaryDisabled AC_SWIFT_PRIVATE = @"background_primary_disabled";

/// The "icon_chatab_default" asset catalog image resource.
static NSString * const ACImageNameIconChatabDefault AC_SWIFT_PRIVATE = @"icon_chatab_default";

/// The "icon_dashboardtab_default" asset catalog image resource.
static NSString * const ACImageNameIconDashboardtabDefault AC_SWIFT_PRIVATE = @"icon_dashboardtab_default";

/// The "image_cure_white_home" asset catalog image resource.
static NSString * const ACImageNameImageCureWhiteHome AC_SWIFT_PRIVATE = @"image_cure_white_home";

#undef AC_SWIFT_PRIVATE
