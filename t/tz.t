use strict;
use warnings;
use Test::More;
use Time::Moment;
use Role::Tiny ();
use DateTime::TimeZone;

my $tz = DateTime::TimeZone->new(name => 'Asia/Pyongyang');

my $class = Role::Tiny->create_class_with_roles('Time::Moment', 'Time::Moment::Role::TimeZone');
my $tm = $class->now_utc;
my $tm_si = $tm->with_time_zone_offset_same_instant($tz);
is $tm->epoch, $tm_si->epoch, 'same instant';
isnt $tm->strftime('%T'), $tm_si->strftime('%T'), 'different local time';
my $tm_sl = $tm->with_time_zone_offset_same_local($tz);
isnt $tm->epoch, $tm_sl->epoch, 'different instant';
is $tm->strftime('%T'), $tm_sl->strftime('%T'), 'same local time';

$tm = Time::Moment->now_utc;
Role::Tiny->apply_roles_to_object($tm, 'Time::Moment::Role::TimeZone');
$tm_si = $tm->with_time_zone_offset_same_instant($tz);
is $tm->epoch, $tm_si->epoch, 'same instant';
isnt $tm->strftime('%T'), $tm_si->strftime('%T'), 'different local time';
$tm_sl = $tm->with_time_zone_offset_same_local($tz);
isnt $tm->epoch, $tm_sl->epoch, 'different instant';
is $tm->strftime('%T'), $tm_sl->strftime('%T'), 'same local time';

done_testing;
