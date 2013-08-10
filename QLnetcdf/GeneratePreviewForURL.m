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
    @autoreleasepool {
        NSString* filepath = (__bridge NSString*)CFURLCopyFileSystemPath(url, kCFURLPOSIXPathStyle);
        
        
        /* pretty much directly copied from here:
         http://stackoverflow.com/questions/412562/execute-a-terminal-command-from-a-cocoa-app/696942#696942
        */
        NSTask *task;
        task = [[NSTask alloc] init];
        [task setLaunchPath: @"/usr/local/bin/ncdump"];
        
        NSArray *arguments;
        arguments = [NSArray arrayWithObjects: @"-h", filepath, nil];
        [task setArguments: arguments];
        
        NSPipe *pipe;
        pipe = [NSPipe pipe];
        [task setStandardOutput: pipe];
        
        NSFileHandle *file;
        file = [pipe fileHandleForReading];
        
        [task launch];
        
        NSData *data;
        data = [file readDataToEndOfFile];
        
        NSString *ncdump_result;
        ncdump_result = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        //NSLog (@"ncdump returned:\n%@", ncdump_result);
        
        NSData* ncdumpdata = [ncdump_result dataUsingEncoding:NSUTF8StringEncoding];
        
        // Pass preview data to QuickLook
        QLPreviewRequestSetDataRepresentation(preview,
                                              (__bridge CFDataRef)ncdumpdata,
                                              kUTTypePlainText,
                                              NULL);
        
    }

    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
