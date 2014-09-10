QLNetcdf
========
A QuickLook Plugin for previewing 
[NetCDF](http://www.unidata.ucar.edu/software/netcdf/) files. Use 'spacebar' 
when navigating in OSX Finder to view the "header" (info ouput by `ncdump -h`) 
for NetCDF files.

__Requires that `ncdump` is installed at `/usr/local/bin` !__

Fortunately if you installed `netcdf` using [Homebrew](http://brew.sh) (with 
the default settings) then `ncdump` should exist in the correct location 
already.

Example
-------
Here is an example.

[some txt](images/example0.png)

![Screen shot](/images/example0.png?raw=true "QLNetcdf generator in action")

Installing
-----------
Download one of the releases and copy the QLNetcdf.qlgenerator file to your 
`~/Library/QuickLook/` directory (or `/Library/QuickLook/` to make the plugin 
available to all users).

You may have to force the QuickLook Server to reload so it picks up the new 
generator:

    $ qlmnange -r


Building
--------
The xcode project file is supplied with the project. The project has been built
with xcode 4.6 and xcode 5.1
