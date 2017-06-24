# Bastion with google authenticator
A simple ssh bastion using public keys and google authenticator to keep thing safe.

## Usage
Since host keys are generated on demand upon launch, you might want to
store them in a separate data container. For this purpose the VOLUME
`/etc/ssh` is defined and may used like:
```
$ docker create --name bastion-data neochrome/bastion:latest
$ docker run --volumes-from bastion-data -p 2222:22 neochrome/bastion:latest
```

The user `bastion` is used for connection:
```
$ ssh bastion@hostname
```

### google-authenticator
Upon first connection `google-authenticator` will be run in order to
setup two-factor authentication.

If you have previous settings or want to share the generated ones
between multiple bastions or for safe-keep when upgrading, please use
a data container as shown above.

### authorized_keys
In order to authenticate public keys need to be made available to the
bastion. This may be done in a derived image by adding the key(s) to
`/bastion/authorized_keys`, don't forget to set owner to `bastion:users`.
Another way is to use another defined VOLUME, `/bastion` and create a
data container as shown above.

### motd
The image comes without a `/etc/motd` file. If you want one, you may either
mount one or add one to a derived image.
