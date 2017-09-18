# guess-type.pl

Collect and print type informations from arguments for `Smart::Args`.

## usage

```
carton exec -- perl guess-type.pl TARGET_FILES.pm

```

## example

```
% carton exec -- perl guess-type.pl examples/example.pl
examples/example.pl at guess-type.pl line 57.
{
    $body          {
        Str   1
    },
    $new_profile   {
        Str   1
    },
    $user          {
        Model::User   2
    }
}
```
