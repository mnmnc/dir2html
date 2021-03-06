dir2html
========

This powershell script is generating html output from directory listing.

========

There was a day when I was searching for some files inside a directory which had multiple sub-directories. Of course there is a Windows search tool that can help you to some extent but – it will not allow you to view multiple directories at the same time while highlighting files of particular kind – this is what I wanted.
Below there is a powershell script that does exactly that listing directory content and creating a html file to let you see and (in some cases) easily open files.

Each file is displayed as a tile like this one:

![file icon](https://raw.githubusercontent.com/mnmnc/img/master/file.jpg)


On each tile there is
* filename, 
* file size, 
* date of last modification.

The web page generated will look like this:

![directory as html document](https://raw.githubusercontent.com/mnmnc/img/master/smallkafel.jpg)

For now you can open specific files directly from generated html page:
* txt, 
* cpp, 
* c, 
* hpp, 
* h, 
* gif, 
* tiff, 
* jpg, 
* jpeg, 
* png, 
* bmp, 
* pdf, 
* html, 
* htm 


File size is displayed in either Bytes, KiloBytes or MegaBytes – if the size is bigger than 1024 Bytes it will be shown in KiloBytes.

Feel free to modify the script to add your coloring preference just by creating or altering a CSS style. If you come up with something cool - let me know.
