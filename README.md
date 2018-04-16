# limits

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with limits](#setup)
    * [Setup requirements](#setup-requirements)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Development - Guide for contributing to the module](#development)

## Description

- This module manages security limits configurations.

### Compatibility

  - EL 5
  - EL 6
  - EL 7

#### Tested Puppet Versions

  - 3.8.x
  - 2015.3.x
  - 5.x


## Setup

### Setup Requirements **OPTIONAL**

This module requires that you have the following depedencies installed.
- `puppetlabs-stdlib >= 4.13.0 < 5.0.0`

## Usage

- To configure a user specific limits configuration.

```
limits::fragment { 'some-user':
  list => [
           'some-user soft nproc 8192',
           'some-user hard nproc 8192',
  ]
}
```
This example will create a file `/etc/security/limits.d/some-user.conf` that has the following contents
```
# This file is being maintained by Puppet.
# DO NOT EDIT

some-user soft nproc 8192
some-user hard nproc 8192
```

### Hiera example

- To use limits with hiera you first must include the `::limits` class
```
  include ::limits
```

- Next, update your specific hiera yaml file to use bound parameters
  * where `limits::fragments` is the name of the bound param
  * where `foo` is the name of the fragement file
  * where `list` is the array of items we want to add the `/etc/security/limits.d/foo.conf`

```
limits::fragments:
  foo:
    list:
      - * soft nproc 1024
      - * hard nproc 1024
```


## Reference

### Classes

####'limits'

- Takes no parameters just include it an go.

### Defined Types

#### limits::fragment

ensure
------

- Specifies the state of the limits config file ['file', 'present', 'absent']

list
----

- Array of items that will be added to the limits config file.


## Development

* Fork it
* Write rspec unit tests
* Write beaker acceptance tests
* Submit pull request
