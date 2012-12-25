package Lingua::EN::Number::IsOrdinal;

use strict;
use warnings;
use Exporter 'import';
use Lingua::EN::FindNumber 'extract_numbers';

=encoding UTF-8

=head1 NAME

Lingua::EN::Number::IsOrdinal - detect if English number is ordinal or cardinal

=head1 SYNOPSIS

    use Lingua::EN::Number::IsOrdinal 'is_ordinal';

    ok is_ordinal('first');

    ok !is_ordinal('one');

    ok is_ordinal('2nd');

    ok !is_ordinal('2');

=head1 DESCRIPTION

This module will tell you if a number, either in words or as digits, is a
cardinal or L<ordinal
number|http://www.ego4u.com/en/cram-up/vocabulary/numbers/ordinal>.

This is useful if you e.g. want to distinguish these types of numbers found with
L<Lingua::EN::FindNumber> and take different actions.

=cut

our @EXPORT_OK = qw/is_ordinal/;

my $ORDINAL_RE = qr/(?:first|st|second|nd|third|rd|th)\s*$/;

my $NUMBER_RE  = qr/^\s*(?:[+-]?)(?=\d|\.\d)\d*(?:\.\d*)?(?:[Ee](?:[+-]?\d+))?(?:st|nd|rd|th)?\s*$/;

my $is_number = sub {
    my $text = shift;
    s/^\s+//, s/\s+$// for $text;
    
    my @nums = extract_numbers $text;

    return undef if (@nums != 1 || $nums[0] ne $text) && $text !~ $NUMBER_RE;

    return 1;
};

=head1 FUNCTIONS

=head2 is_ordinal

Takes a number as English words or digits (with or without ordinal suffix) and
returns C<1> for ordinal numbers and C<undef> for cardinal numbers.

Checks that the whole parameter is a number using L<Lingua::EN::FindNumber> or
a regex in the case of digits, and if it isn't will throw a C<not a number>
exception.

This function can be optionally imported.

=cut

sub is_ordinal {
    my $num = shift;

    die "not a number" unless $is_number->($num);

    return $num =~ $ORDINAL_RE ? 1 : undef;
}

=head1 SEE ALSO

=over 4

=item * L<Lingua::EN::FindNumber>

=item * L<Lingua::EN::Words2Nums>

=item * L<Lingua::EN::Inflect::Phrase>

=back

=head1 AUTHOR

Rafael Kitover <rkitover@cpan.org>

=cut

1;
