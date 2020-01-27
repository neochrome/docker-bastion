# Bastion with google authenticator
A simple ssh bastion using public keys and
[google authenticator](https://github.com/google/google-authenticator-libpam)
to keep things safe.

## Usage
Since host keys are generated on demand upon launch, you might want to
store them in a separate data container. For this purpose the VOLUME
`/etc/ssh` is defined and may used like:

```
$ docker volume create bastion-keys
$ docker run -v "bastion-keys:/etc/ssh" -p 2222:22 neochrome/bastion:latest
```

The user `bastion` is used for connection:
```
$ ssh bastion@hostname
```

### google-authenticator
Upon first connection `google-authenticator` will be run in order to
setup two-factor authentication.

If you have previous settings or want to share the generated ones
between multiple bastions or for safe-keep when upgrading, use
a volume like this:

```
$ docker volume create bastion-ga
$ docker run -v "bastion-ga:/bastion" -p 2222:22 neochrome/bastion:latest
```

You may also use a data container to handle both volumes together. E.g:

```
$ docker create --name bastion-data neochrome/bastion:latest
$ docker run --volumes-from bastion-data -p 2222:22 neochrome/bastion:latest
```

### authorized_keys
In order to authenticate, public keys need to be made available to the bastion.
This may be done in a couple of different ways:
1. Bind mount your public key file or existing `authorized_keys` file as `/authorized_keys`,
the container will then copy the `authorized_keys` file in place and set correct permissions
upon launch.
2. Create a derived image (`FROM neochrome/bastion:latest`) and add the key(s) to
`/bastion/authorized_keys`, don't forget to set owner to `bastion:users`.
3. Use volume populated with a `/bastion/authorized_keys` file with correct ownership set
and mounted as `/bastion`.
4. Like 2, but managed in a data container.

### motd
The image comes without a `/etc/motd` file. If you want one, you may either:
1. Add one to a derived image.
2. Mount one at `/motd` and then the container will copy it in place upon launch.
3. Mount one at `/etc/motd`.
