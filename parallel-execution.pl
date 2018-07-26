#!/usr/bin/perl

use strict;
use Parallel::ForkManager;
 
my $max_procs = 10;
my @names = qw( RobotWorker1 RobotWorker2 RobotWorker3 RobotWorker4 RobotWorker5 RobotWorker6 RobotWorker7 RobotWorker8 RobotWorker9 RobotWorker10 );
# hash to resolve PID's back to child specific information
 
my $pm = Parallel::ForkManager->new($max_procs);
 
# Setup a callback for when a child finishes up so we can
# get it's exit code
$pm->run_on_finish( sub {
    my ($pid, $exit_code, $ident) = @_;
    print "** $ident just got out of the pool ".
      "with PID $pid and exit code: $exit_code\n";
});
 
$pm->run_on_start( sub {
    my ($pid, $ident)=@_;
    print "** $ident started, pid: $pid\n";
});
 
$pm->run_on_wait( sub {
    print "** Have to wait for one RobotWorker ...\n"
  },
  0.5
);
 
NAMES:
foreach my $child ( 0 .. $#names ) {
  my $pid = $pm->start($names[$child]) and next NAMES;
 
  # This code is the child process
  print "This is $names[$child], RobotWorker number $child\n";
  sleep ( 2 * $child );
  print "$names[$child], RobotWorker $child is about to get out...\n";
  sleep 1;
  $pm->finish($child); # pass an exit code to finish
}
 
print "Waiting for RobotWorkers...\n";
$pm->wait_all_children;
print "Everybody is out of the dry pool!\n";
