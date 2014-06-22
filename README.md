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
