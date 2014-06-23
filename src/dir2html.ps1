$global:current_dir="";
$global:open=0;
$root=($(pwd).Path).Length;
 
$out = "
<html>
  <head>
  <style>
    body {
      padding: 0px;
      margin: 0px;
      background-color: rgb(30,30,30);
      background-image: -ms-linear-gradient(top left, #3F0F63 0%, #930AEF 100%);
      background-image: -moz-linear-gradient(top left, #3F0F63 0%, #930AEF 100%);
      background-image: -o-linear-gradient(top left, #3F0F63 0%, #930AEF 100%);
      background-image: -webkit-gradient(linear, left top, right bottom, color-stop(0, #3F0F63), color-stop(1, #930AEF));
      background-image: -webkit-linear-gradient(top left, #3F0F63 0%, #930AEF 100%);
      background-image: linear-gradient(to bottom right, #3F0F63 0%, #930AEF 100%);
    }
    div.directory {
      border: 2px solid rgb(155,155,155);
      border-bottom: 0px;
      padding: 5px;
      overflow:auto;
    }
    div.dirtitle {
      font-family: Verdana;
      font-size: 11px;
      color: rgb(140,140,140);
      text-align:left;
      padding: 3px;
      margin: 3px;
      width: 95%;
    }
    div.file {
      border: 2px solid rgb(30,30,30);
      width: 80px;
      height: 80px;
      float: left;
      position: relative;
      padding: 3px;
      text-align:center;
      color: white;
    }
    span.filename {
      font-family: Verdana;
      font-size: 12px;
      line-height: 40px;
    }
    span.filesize {
      font-family: Verdana;
      font-size: 10px;
    }
    span.mod_date {
      font-family: Verdana;
      font-size: 10px;
    }
    .word {
      background-color: rgb(82,82,82);
    }
    div.file:hover {
        border: 2px solid rgb(72,72,72);
    }
    .orange {
      background-color: rgb(218, 83, 44);
    }
    .green {
      background-color: rgb(0, 163, 0);
    }
    .purple {
      background-color: rgb(185, 29, 71);
    }
    .blue {
      background-color: rgb(45, 137, 239);
    }
    .yellow {
        background-color: rgb(255, 196, 13);
    }
    .violet {
      background-color: rgb(159, 0, 167);
    }
    .black {
      color: white;
      background-color: rgb(0, 0, 0);
    }
    .gray {
      background-color: rgb(100, 100, 100);
    }
    .red {
      background-color: rgb(224, 25, 61);
    }
  </style>
</head>
<body>";
 
Write-Output $out >> test.html ;
 
Get-ChildItem -recurse | where { $_.PSIsContainer -eq $false } |% {
 # NO TILES FOR DIRECTORIES
 if ( [string]$global:current_dir -ne [string]$_.Directory ){
  if ( $global:open -eq 0 )
  {
   $global:open=1;
   $out= "<div id='directory' class='directory'> <div id='dirtitle' class='dirtitle'>" + $_.Directory + "</div>";
   Write-Output $out >> test.html ;
  }
  else
  {
   $out = " </div><div id='directory' class='directory'> <div id='dirtitle' class='dirtitle'>" + $_.Directory + "</div> ";
   Write-Output $out >> test.html;
  }
  $global:current_dir=$_.Directory;
 }
 
 # CORRECTING PATH
 $relPath = $_.FullName.Remove(0, $root + 1)
 $relPath = $relPath -replace "\\", "/"
 
 # HTML
 if ( $_.Extension -eq ".html" -or $_.Extension -eq ".htm")
 {
  $out= "<div class='file yellow' onclick='window.location=`"" + ($relPath).trim() + "`"'>";
  Write-Output $out >> test.html ;
 }
 # TEXT FILES
 elseif ( $_.Extension -eq ".txt" -or $_.Extension -eq ".cpp" -or $_.Extension -eq ".c" -or $_.Extension -eq ".h" -or $_.Extension -eq ".hpp")
 {
  $out= "<div class='file black' onclick='window.location=`"" + $relPath + "`"'>";
  Write-Output $out >> test.html ;
 }
 # PDF
 elseif ( $_.Extension -eq ".pdf" )
 {
  $out= "<div class='file violet' onclick='window.location=`"" + $relPath + "`"'>";
  Write-Output $out >> test.html ;
 }
 # PICTURES
 elseif ( $_.Extension -eq ".jpg" -or $_.Extension -eq ".gif" -or $_.Extension -eq ".png" or $_.Extension -eq ".jpeg" -or $_.Extension -eq ".bmp" -or $_.Extension -eq ".tiff" )
 {
  $out= "<div class='file purple' onclick='window.location=`"" + $relPath + "`"'>";
  Write-Output $out >> test.html ;
 }
 else
 {
  $out = "<div class='file gray' >";
  Write-Output $out >> test.html
 }
 
 # REMOVING HYPHEN FROM FILENAMES
 # SINCE IT CAUSES MULTIPLE LINES
 # TO BE GENERATED PER FILENAME
 $sanit= $_.BaseName -replace "-", "_"
 
 # SHOWS ONLY FIRST 9 CHARACTERS FROM FILE NAME
 # TO AVOID OVERFLOW
 if ( ($sanit).Length -gt 9 )
 {
  $out= "`t<span id='filename' class='filename'>" + ($sanit).Substring(0,9) + "</span>";
 }
 else
 {
  $out= "`t<span id='filename' class='filename'>" + $sanit + "</span>";
 }
 Write-Output $out >> test.html;
 
 $var=$_.Length;
 
 # SIZE BIGGER THAN MB
 if ( $var -gt 1048576 )
 {
  $var=$var/1048576;
  $var = "{0:N2}" -f $var
  $out = "`t<span id='filesize' class='filesize'>" + ([string]$var).trim() + " MB</span>";
  Write-Output $out >> test.html;
 }
 else
 {
  # SIZE BIGGER THAN KB
  if ( $var -gt 1024 )
  {
   $var=$var/1024;
   $var = "{0:N2}" -f $var
   $out = "`t<span id='filesize' class='filesize'>" + ([string]$var).trim() + " KB</span>";
   Write-Output $out >> test.html;
  }
  else
  {
   $out = "`t<span id='filesize' class='filesize'>" + ([string]$var).trim() + " B</span>";
   Write-Output $out >> test.html;
  }
 }
 $out = "`t<span id='mod_date' class='mod_date'>" + $_.LastWriteTime + "<span>"
 Write-Output $out >> test.html ;
 Write-Output "</div>" >> test.html;
 Write-Output "`n" >> test.html;
}
Write-Output "</div></body></html>" >> test.html;