name 'nagios3'
maintainer 'DennyZhang.com'
maintainer_email 'denny@dennyzhang.com'
license 'All rights reserved'
description 'Setup nagios3 with common checks predefined'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.7.5'
issues_url 'http://www.dennyzhang.com'
source_url 'http://www.dennyzhang.com'

supports 'arch'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'freebsd'
supports 'redhat'
supports 'scientific'
supports 'smartos'
supports 'suse'
supports 'ubuntu'

depends 'apache2'
depends 'apt'
depends 'yum-epel'
