use Smart::Args qw(args args_pos);

sub tweet {
    args
         my $user => 'Model::User',
         my $body => 'Str';

    $user->tweet($body);
}

use Smart::Args qw(args args_pos);

sub update_profile {
    args_pos
         my $user => 'Model::User',
         my $new_profile => 'Str';

    $user->set_profile($profile);
}
