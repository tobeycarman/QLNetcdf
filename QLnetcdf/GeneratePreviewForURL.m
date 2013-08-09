#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#import <Cocoa/Cocoa.h>

#include <netcdf.h>
OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

void handle_error(int status);


/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    // To complete your generator please implement the function GeneratePreviewForURL in GeneratePreviewForURL.c
    int status, ncid, ndims, nvars, ngatts, unlimdimid;
    
    //NSString* ncfstring;
    //NSString* ncfstring = (__bridge_transfer NSString*)CFURLGetString(url);
    //const char *c = [ncfstring UTF8String];

    NSString* ncfs = (__bridge_transfer NSString*)CFURLCopyFileSystemPath(url, kCFURLPOSIXPathStyle);
    const char* c = ncfs.UTF8String;
    
    status = nc_open(c, NC_NOWRITE, &ncid);
    
    status = nc_inq(ncid, &ndims, &nvars, &ngatts, &unlimdimid);
    if (status != NC_NOERR) handle_error(status);
    
    NSLog(@"INFO (status: %i), (ncid: %i), (ndims: %i), (nvars: %i), (ngatts: %i), (unlimdimid: %i),", status, ncid, ndims, nvars, ngatts, unlimdimid);
    NSLog(@"HUH? %i",status);
    NSLog(@"The file path is: %s", c);
    handle_error(status);


    //if (status != NC_NOERR) printf("WTF!!?\n"); //handle_error(status);
    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
/*
NSString *getUrlPath(CFURLRef url)
{
    // return path component of a URL
    NSString *path = [[(NSURL *)url absoluteURL] path];
    return [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}*/

void handle_error(int status) {
    if (status != NC_NOERR) {
        fprintf(stderr, "%s\n", nc_strerror(status));
        exit(-1);
    }
}
