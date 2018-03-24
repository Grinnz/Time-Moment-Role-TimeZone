use strict;
use warnings;
use Test::More;
use Time::Moment;
use Role::Tiny ();

{package My::Fake::TimeZone;
  sub new { bless {} }
  sub offset_for_datetime { 0 }
  sub offset_for_local_datetime { 0 }
  sub is_dst_for_datetime { 0 }
}

my $tz = My::Fake::TimeZone->new;

my $class = Role::Tiny->create_class_with_roles('Time::Moment', 'Time::Moment::Role::TimeZone');
my $tm = $class->now;

my $tm_si = $tm->with_time_zone_offset_same_instant($tz);
is $tm_si->offset, 0, 'right offset';
my $tm_sl = $tm->with_time_zone_offset_same_local($tz);
is $tm_sl->offset, 0, 'right offset';

$tm = Time::Moment->now;
Role::Tiny->apply_roles_to_object($tm, 'Time::Moment::Role::TimeZone');

$tm_si = $tm->with_time_zone_offset_same_instant($tz);
is $tm_si->offset, 0, 'right offset';
$tm_sl = $tm->with_time_zone_offset_same_local($tz);
is $tm_sl->offset, 0, 'right offset';

done_testing;
