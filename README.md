# Bastion with google authenticator

## Usage
Derive an image from this one in order to have host keys generated and
stored within the resulting image.
The image contains only one user, named `bastion` with it's home set
to `/bastion`. I.e, one must connect as the `bastion` user like so:
```
$ ssh bastion@hostname
```
Please see [Dockerfile.example](Dockerfile.example) for a minimal example of this.

### google-authenticator
Upon first connection `google-authenticator` will be run in order to
setup two-factor authentication.

If you have previous settings or want to share the generated ones
between multiple bastions, please use VOLUMEs to share the `/bastion` folder
or specifically `/bastion/.google-authenticator`.

### authorized_keys
Either add `COPY authorized_keys /bastion/authorized_keys` to your `Dockerfile`
or use VOLUMEs to share such a file.
If you add the file to your image, remember to set owner to `bastion:users`.

### motd
The image comes without a `/etc/motd` file. If you want one, you may add a
`COPY my_motd /etc/motd` command to your `Dockerfile`.
