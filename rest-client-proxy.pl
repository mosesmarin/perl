#!/usr/bin/perl

use REST::Client;
 
#The basic use case
my $client = REST::Client->new();
$client->getUseragent()->proxy(['http'], 'http://107.150.46.198:53281');
$client->GET('http://services.groupkt.com/country/get/all');
print $client->responseContent();
  
