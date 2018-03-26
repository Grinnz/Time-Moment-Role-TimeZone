use strict;
use warnings;
use Test::More;
use Time::Moment;
use Role::Tiny ();

my $system = Time::Moment->now;
plan skip_all => 'System time is UTC' if $system->offset == 0;

my $class = Role::Tiny->create_class_with_roles('Time::Moment', 'Time::Moment::Role::TimeZone');
my $tm = $class->now_utc;

my $tm_si = $tm->with_systemtime_offset_same_instant;
is $tm->epoch, $tm_si->epoch, 'same instant';
isnt $tm->strftime('%T'), $tm_si->strftime('%T'), 'different local time';
is $tm_si->offset, $system->offset, 'right offset';
my $tm_sl = $tm->with_systemtime_offset_same_local;
isnt $tm->epoch, $tm_sl->epoch, 'different instant';
is $tm->strftime('%T'), $tm_sl->strftime('%T'), 'same local time';
is $tm_sl->offset, $system->offset, 'right offset';

done_testing;
