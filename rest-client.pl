#!/usr/bin/perl

use REST::Client;
 
#The basic use case
my $client = REST::Client->new();
$client->GET('http://127.0.0.1:5000/');
print $client->responseContent();
  
