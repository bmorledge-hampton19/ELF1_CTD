#!/usr/bin/perl

use strict;
use warnings;

my %genome;
my $chr = "";
while ( <STDIN> )
{
	chomp $_;
	if ( $_ =~ /(chr[XIVM]+)/ )
	{
		print $_ . "\n";
		$chr = $1;
	}
	else
	{
		$genome{$chr} .= $_;
	}

}

open ( PLUS, ">initial_plus_dipyrimidines.wig" );
open ( MINUS, ">initial_minus_dipyrimidines.wig" );
# find dipyrimindes in plus strand
foreach my $chrom (sort keys %genome )
{
	print "Processing $chrom\n";
	print PLUS "variableStep chrom=$chrom span=1\n";
        print MINUS "variableStep chrom=$chrom span=1\n";

	my $prev_plus_dipy_flag = 0;
	my $prev_minus_dipy_flag = 0;
	my $seq = $genome{$chrom};
	for ( my $i = 0; $i < length($seq) - 1; $i++ )
	{
		my $subseq = substr( $seq, $i, 2 );
		if ( $subseq =~ /[CT][CT]/ )
		{
			if ( $prev_plus_dipy_flag == 0 )
			{
				my $j = $i + 1;
				print PLUS "$j\t0.0\n";
			}
			my $k = $i + 2;
			print PLUS "$k\t0.0\n";
			$prev_plus_dipy_flag = 1;
		}
		else
		{
			$prev_plus_dipy_flag = 0;
		}
                if ( $subseq =~ /[AG][AG]/ )
                {
                        if ( $prev_minus_dipy_flag == 0 )
                        {
				my $j = $i + 1;
                                print MINUS "$j\t0.0\n";
                        }
                        my $k = $i + 2;
                        print MINUS "$k\t0.0\n";
                        $prev_minus_dipy_flag = 1;
                }
                else
                {
                        $prev_minus_dipy_flag = 0;
                }

	}

} 
close (PLUS);
close (MINUS);
