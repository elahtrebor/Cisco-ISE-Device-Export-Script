#!/usr/bin/perl

$pageCount = 1;
$username = "YourERSUser";
$pw = "YourErsPW";
$output = "nextPage";

$curlCommand = "curl -s -k --include --header 'Accept: application/json'  --user '$username:$pw' 'https://YourISEHost:9060/ers/config/networkdevice?size=100&page=PAGENUM'";

while($output =~/nextPage/){
 $currentCommand = $curlCommand;
 $currentCommand=~s/PAGENUM/$pageCount/;
 $output = `$currentCommand`;
 (@data) = split(/\}, \{/, $output);
 foreach $elem(@data){
  if($elem=~/\"id\" \: \"/){
     # parse out the data
    ($id) = ($elem=~/\"id\" \: \"(.*?)\"/g);
    ($name) = ($elem=~/\"name\" \: \"(.*?)\"/g);
    ($link) = ($elem=~/\"href\" \: \"(.*?)\"/g);
    # get details
     $detaildata = `curl -s -k --include --header 'Accept: application/json'  --user '$username:$pw' '$link'`;
    print $detaildata;
   }
  }
 
 $pageCount++;
}
 
