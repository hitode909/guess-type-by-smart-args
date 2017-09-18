use strict;
use warnings;
use PPI;
use Path::Class qw(file);
use DDP { show_unicode => 1, use_prototypes => 0, colored => 0 };


sub scan_args {
    my ($result, @tokens) = @_;
    my $args = shift @tokens;

    while ($tokens[0] eq 'my') {

        my $my = shift @tokens;

        my $variable = shift @tokens;

        # my $self, pattern
        if ($tokens[0]->content eq ',') {
            shift @tokens;
            next;
        }
        if ($tokens[0]->content eq ';') {
            return;
        }

        my $equal = shift @tokens;

        if ($tokens[0] eq '+') {
            shift @tokens;
        }


        my $type = shift @tokens;
        $result->{$variable->content} //= {};

        if ($type->isa('PPI::Token::Quote')) {
            $result->{$variable->content}->{$type->literal}++;
        } else {
            $result->{$variable->content}->{$type->content}++;
        }

        # last ;
        if ($tokens[0]->content eq ',') {
            shift @tokens;
        }
        if ($tokens[0]->content eq ';') {
            return;
        }
    }
    warn "rest: @{[ join(' ', @tokens) ]}";

}

sub collect_types {
    my ($result, $file) = @_;
    warn $file;
    my $content = file($file)->slurp;
    my $document = PPI::Document->new(\$content);

    my $statements = $document->find('PPI::Statement') || [];
    for my $statement (@$statements) {
        my @schildren = $statement->schildren;
        next unless $schildren[0] eq 'args' || $schildren[0] eq 'args_pos';
        scan_args($result, @schildren);
    }
}

my $result = {};

for my $file (@ARGV) {
    collect_types($result, $file);
}

p $result;
