#!/usr/bin/perl
use v5.10.1;

my %priority = (
  a => 1,
  b => 2,
  c => 3,
  d => 4,
  e => 5,
  f => 6,
  g => 7,
  h => 8,
  i => 9,
  j => 10,
  k => 11,
  l => 12,
  m => 13,
  n => 14,
  o => 15,
  p => 16,
  q => 17,
  r => 18,
  s => 19,
  t => 20,
  u => 21,
  v => 22,
  w => 23,
  x => 24,
  y => 25,
  z => 26,
  A => 27,
  B => 28,
  C => 29,
  D => 30,
  E => 31,
  F => 32,
  G => 33,
  H => 34,
  I => 35,
  J => 36,
  K => 37,
  L => 38,
  M => 39,
  N => 40,
  O => 41,
  P => 42,
  Q => 43,
  R => 44,
  S => 45,
  T => 46,
  U => 47,
  V => 48,
  W => 49,
  X => 50,
  Y => 51,
  Z => 52,
);

open(my $in,  "<",  "input.txt")  or die "Can't open input.txt: $!";
my @lines = <$in>;

# part 1
sub splitInHalf {
  my $s = shift;
  return (
    substr($s, 0, length($s) / 2), 
    substr($s, length($s) / 2)
  );
}

sub findShared {
  my ($a, $b) = @_;
  foreach (split //, $a) {
    if (index($b, $_) > -1) {
      return $_;
    }
  }
}

my $total = 0;
foreach (@lines) {
  my ($a, $b) = splitInHalf($_);
  my $shared = findShared($a, $b);
  $total += %priority{$shared};
}

say $total;

# part 2
sub findSharedFor3 {
  my ($a, $b, $c) = @_;
  foreach (split(//, $a)) {
    if ($b =~ $_ && $c =~ $_) {
      return $_;
    }
  }
}

my $total2 = 0;
for ($i = 0; $i < scalar @lines; $i += 3) {
  my $shared = findSharedFor3 @lines[$i, $i+1, $i+2];
  $total2 += %priority{$shared};
}

say $total2;