#!/usr/bin/perl

use Test::Simple tests => 6;

use Time::Available qw(:days :fmt_interval);

my $i = Time::Available->new( start=>'07', end=>'17:15', dayMask=>DAY_WEEKDAY);
ok( defined($i) , 'new() work');

ok( defined($i->{start}) && $i->{start} == 7*60*60, 'start time ok' );
ok( defined($i->{end}) && $i->{end} == ((17*60)+15)*60, 'end time ok' );

my $t = 1 * 24;	# 1d
$t += 11;	# 11 hr
$t *= 60;
$t += 11;	# 11 min
$t *= 60;
$t += 11;	# 11 sec

ok( fmt_interval($t) eq '1d 11:11:11', 'fmt_interval output ok');

# 20000 = Thu Jan  1 06:33:20 1970
# 30000 = Thu Jan  1 09:20:00 1970
# 50000 = Thu Jan  1 14:53:20 1970
# 60000 = Thu Jan  1 17:40:00 1970

# test this timespan (07:00-17:15) with above values

#ok($i->uptime(20000)==36900,'ok');
#ok($i->uptime(30000)==28500,'ok');
#ok($i->uptime(50000)==8500,'ok');
#ok($i->uptime(60000)==0,'ok');

# create and test timespan which spans over midnight

$i = Time::Available->new( start=>'17:15', end=>'07:00', dayMask=>DAY_THURSDAY);
ok( defined($i->{start}) && $i->{start} == ((17*60)+15)*60, 'end time ok' );
ok( defined($i->{end}) && $i->{end} == 7*60*60, 'start time ok' );

#ok($i->uptime(20000)==25900,'ok');
#ok($i->uptime(30000)==24300,'ok');
#ok($i->uptime(50000)==24300,'ok');
#ok($i->uptime(60000)==22800,'ok');

#$t=time();$u=$i->uptime($t);print STDERR " uptime ( $t $u ) ",scalar localtime $t,": ",fmt_interval($u)," ($u)\n";


$i = Time::Available->new( start=>'07:00', end=>'17:00', dayMask=>DAY_WEEKDAY, DEBUG=>1);

print STDERR "\n",$i->interval(100000,500001),"\n\n";
print STDERR "\n",$i->interval(200100000,200500001),"\n\n";
print STDERR "\n",$i->interval(1061478325,1061478819),"\n\n";
print STDERR "\n",$i->interval(1061550928,1061551126),"\n\n";
print STDERR "\n",$i->interval(1049666442,1050351024),"\n\n";
print STDERR "\n",$i->interval(1061768345,1061773119),"\n\n";
print STDERR "\n",$i->interval(1061507423,1061541821),"\n\n";
print STDERR "\n",$i->interval(1051482879,1051491233),"\n\n";
