#!/usr/bin/perl

use Test::Simple tests => 14;

use Time::Available qw(:days :fmt_interval);
use Time::Local;

my $tz_offset = time()-timegm(localtime);

my $i = Time::Available->new( start=>'07', end=>'17:15', dayMask=>DAY_WEEKDAY);
ok( defined($i) , 'new() work');

ok( defined($i->{start_arr}) &&
	$i->{start_arr}[0] == 0 &&
	$i->{start_arr}[1] == 0 &&
	$i->{start_arr}[2] == 7,
	'start time ok' );
ok( defined($i->{end_arr}) &&
	$i->{end_arr}[0] == 0 &&
	$i->{end_arr}[1] == 15 &&
	$i->{end_arr}[2] == 17,
	'end time ok' );

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

ok($i->uptime(20000)==36900,'ok');
ok($i->uptime(30000)==28500,'ok');
ok($i->uptime(50000)==8500,'ok');
ok($i->uptime(60000)==0,'ok');

# create and test timespan which spans over midnight

$i = Time::Available->new( start=>'17:15', end=>'07:00', dayMask=>DAY_THURSDAY);
ok( defined($i->{start_arr}) &&
	$i->{start_arr}[0] == 0 &&
	$i->{start_arr}[1] == 15 &&
	$i->{start_arr}[2] == 17,
	'end time ok' );
ok( defined($i->{end_arr}) &&
	$i->{end_arr}[0] == 0 &&
	$i->{end_arr}[1] == 0 &&
	$i->{end_arr}[2] == 7,
	'start time ok' );

ok($i->uptime(20000)==29500,'ok');
ok($i->uptime(30000)==27900,'ok');
ok($i->uptime(50000)==27900,'ok');
ok($i->uptime(60000)==26400,'ok');

